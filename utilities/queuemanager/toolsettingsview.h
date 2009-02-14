/* ============================================================
 *
 * This file is a part of digiKam project
 * http://www.digikam.org
 *
 * Date        : 2008-11-27
 * Description : a view to show Batch Tool Settings.
 *
 * Copyright (C) 2008-2009 Gilles Caulier <caulier dot gilles at gmail dot com>
 *
 * This program is free software; you can redistribute it
 * and/or modify it under the terms of the GNU General
 * Public License as published by the Free Software Foundation;
 * either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * ============================================================ */

#ifndef TOOL_SETTINGS_VIEW_H
#define TOOL_SETTINGS_VIEW_H

// Qt includes.

#include <QStackedWidget>

// Local includes.

#include "batchtool.h"

namespace Digikam
{

class ToolSettingsViewPriv;

class ToolSettingsView : public QStackedWidget
{
    Q_OBJECT

public:

    ToolSettingsView(QWidget *parent=0);
    ~ToolSettingsView();

signals:

    void signalSettingsChanged(const BatchToolSet&);

public slots:

    void slotToolSelected(const BatchToolSet&);

private slots:

    void slotSettingsChanged(const BatchToolSettings&);
    void slotThemeChanged();

private:

    int  viewMode();
    void setViewMode(int mode);
    void setToolSettingsWidget(QWidget *w);

private:

    ToolSettingsViewPriv* const d;
};

}  // namespace Digikam

#endif /* TOOL_SETTINGS_VIEW_H */
