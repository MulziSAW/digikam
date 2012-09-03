/* ============================================================
 *
 * This file is a part of digiKam project
 * http://www.digikam.org
 *
 * Date        : 2012-22-07
 * Description : Icon view for import tool items
 *
 * Copyright (C) 2012 by Islam Wazery <wazery at ubuntu dot com>
 *
 * This program is free software you can redistribute it
 * and/or modify it under the terms of the GNU General
 * Public License as published by the Free Software Foundation
 * either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * ============================================================ */

#ifndef ImportIconView_H
#define ImportIconView_H

// Local includes

#include "importcategorizedview.h"

namespace Digikam
{

class ImageViewUtilities;

class ImportIconView : public ImportCategorizedView
{
    Q_OBJECT

public:

    ImportIconView(QWidget* const parent = 0);
    ~ImportIconView();

    void init(CameraController* const controller);

    ImageViewUtilities* utilities() const;

    int fitToWidthIcons();

    CamItemInfo  camItemInfo(const QString& folder, const QString& file);
    CamItemInfo& camItemInfoRef(const QString& folder, const QString& file);

    virtual void setThumbnailSize(const ThumbnailSize& size);

public Q_SLOTS:

    void deleteSelected(bool permanently = false);
    void deleteSelectedDirectly(bool permanently = false);

    void createGroupFromSelection();
    void createGroupByTimeFromSelection();
    void ungroupSelected();
    void removeSelectedFromGroup();
    void rename();

Q_SIGNALS:

    void previewRequested(const CamItemInfo& info, bool downloadPreview);

private Q_SLOTS:

    void slotRotateLeft(const QList<QModelIndex>&);
    void slotRotateRight(const QList<QModelIndex>&);
    //void slotInitProgressIndicator();

protected:

    virtual void activated(const CamItemInfo& info);
    virtual void showContextMenuOnInfo(QContextMenuEvent* event, const CamItemInfo& info);
    virtual void showContextMenu(QContextMenuEvent* event);
    virtual void slotSetupChanged();

private:

    class Private;
    Private* const d;
};

} // namespace Digikam

#endif // ImportIconView_H
