/* ============================================================
 *
 * This file is a part of digiKam project
 * http://www.digikam.org
 *
 * Date        : 2018-07-30
 * Description : a plugin to render presentation.
 *
 * Copyright (C) 2018-2019 by Gilles Caulier <caulier dot gilles at gmail dot com>
 *
 * This program is free software; you can redistribute it
 * and/or modify it under the terms of the GNU General
 * Public License as published by the Free Software Foundation;
 * either version 2, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * ============================================================ */

#include "presentationplugin.h"

// Qt includes

#include <QPointer>

// KDE includes

#include <klocalizedstring.h>

// Local includes

#include "presentationmngr.h"

namespace Digikam
{

PresentationPlugin::PresentationPlugin(QObject* const parent)
    : DPlugin(parent)
{
}

PresentationPlugin::~PresentationPlugin()
{
}

QString PresentationPlugin::name() const
{
    return i18n("Presentation");
}

QString PresentationPlugin::iid() const
{
    return QLatin1String(DPLUGIN_IID);
}

QIcon PresentationPlugin::icon() const
{
    return QIcon::fromTheme(QLatin1String("view-presentation"));
}

QString PresentationPlugin::description() const
{
    return i18n("A tool to render presentation");
}

QString PresentationPlugin::details() const
{
    return i18n("<p>This tool render a serie of items as an advanced slide-show.</p>"
                "<p>Plenty of transition effects are available are ones based on OpenGL and the famous Ken Burns effect.</p>"
                "<p>You can add a sound-track in background while your presentation.</p>");
}

QList<DPluginAuthor> PresentationPlugin::authors() const
{
    return QList<DPluginAuthor>()
            << DPluginAuthor(QLatin1String("Gilles Caulier"),
                             QLatin1String("caulier dot gilles at gmail dot com"),
                             QLatin1String("(C) 2005-2019"))
            << DPluginAuthor(QLatin1String("Renchi Raju"),
                             QLatin1String("renchi dot raju at gmail dot com"),
                             QLatin1String("(C) 2003-2004"))
            << DPluginAuthor(QLatin1String("Valerio Fuoglio"),
                             QLatin1String("valerio dot fuoglio at gmail dot com"),
                             QLatin1String("(C) 2006-2009"))
            ;
}

void PresentationPlugin::setup(QObject* const parent)
{
    DPluginAction* const ac = new DPluginAction(parent);
    ac->setIcon(icon());
    ac->setText(i18nc("@action", "Presentation..."));
    ac->setObjectName(QLatin1String("presentation"));
    ac->setActionCategory(DPluginAction::GenericView);
    ac->setShortcut(Qt::ALT + Qt::SHIFT + Qt::Key_F9);

    connect(ac, SIGNAL(triggered(bool)),
            this, SLOT(slotPresentation()));

    addAction(ac);
}

void PresentationPlugin::slotPresentation()
{
    DInfoInterface* const iface = infoIface(sender());

    QPointer<PresentationMngr> mngr = new PresentationMngr(this);

    foreach (const QUrl& url, iface->currentSelectedItems())
    {
        DItemInfo info(iface->itemInfo(url));
        mngr->addFile(url, info.comment());
        qApp->processEvents();
    }

    mngr->setPlugin(this);
    mngr->showConfigDialog();
}

} // namespace Digikam
