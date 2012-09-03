/* ============================================================
 *
 * This file is a part of digiKam project
 * http://www.digikam.org
 *
 * Date        : 2012-05-07
 * Description : Item delegate for import interface items.
 *
 * Copyright (C) 2012 by Islam Wazery <wazery at ubuntu dot com>
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

#ifndef ITEMVIEWIMPORTDELEGATE_H
#define ITEMVIEWIMPORTDELEGATE_H

// Local includes

#include "itemviewimportdelegatepriv.h"
#include "thumbnailsize.h"
#include "ditemdelegate.h"
#include "imagedelegateoverlay.h"

namespace Digikam
{

class ImportCategoryDrawer;
class ImportCategorizedView;
class ImportFilterModel;
class ImportImageModel;
class ItemViewImportDelegatePrivate;

class ItemViewImportDelegate : public DItemDelegate, public ImageDelegateOverlayContainer // Some reuse of the existing model-view classes.
{
    Q_OBJECT

public:

    ItemViewImportDelegate(QObject* const parent = 0);
    ~ItemViewImportDelegate();

    ThumbnailSize thumbnailSize() const;
    int           spacing() const;
    QRect         rect() const;

    virtual QSize sizeHint(const QStyleOptionViewItem& option, const QModelIndex& index) const;
    virtual QSize gridSize() const;

    // reimplemented from DItemDelegate
    virtual void setThumbnailSize(const ThumbnailSize& thumbSize);
    virtual void setSpacing(int spacing);
    virtual void setDefaultViewOptions(const QStyleOptionViewItem& option);
    virtual bool acceptsToolTip(const QPoint& pos, const QRect& visualRect,
                                const QModelIndex& index, QRect* tooltipRect = 0) const;
    virtual bool acceptsActivation(const QPoint& pos, const QRect& visualRect,
                                   const QModelIndex& index, QRect* activationRect = 0) const;

    /** Returns the area where the pixmap is drawn,
     *  or null if not supported */
    virtual QRect pixmapRect() const;

    /** Returns the area where the image information is drawn,
     *  or null if empty / not supported.
     *  The image information is textual or graphical information,
     *  but not the pixmap. The ratingRect() will e.g. typically
     *  be contained in this area.
     */
    virtual QRect imageInformationRect() const;

    virtual void mouseMoved(QMouseEvent* e, const QRect& visualRect, const QModelIndex& index);

protected Q_SLOTS:

    void slotThemeChanged();
    void slotSetupChanged();

    virtual void overlayDestroyed(QObject* o);

Q_SIGNALS:

    void requestNotification(const QModelIndex& index, const QString& message);
    void hideNotification();

protected:

    /// Use the tool methods for painting in subclasses
    QRect drawThumbnail(QPainter* p, const QRect& thumbRect, const QPixmap& background, const QPixmap& thumbnail) const;
    void drawName(QPainter* p,const QRect& nameRect, const QString& name) const;
    void drawModificationDate(QPainter* p, const QRect& dateRect, const QDateTime& date) const;
    void drawImageSize(QPainter* p, const QRect& dimsRect, const QSize& dims) const;
    void drawImageFormat(QPainter* p, const QRect& dimsRect, const QString& mime) const;
    void drawFileSize(QPainter* p, const QRect& r, qlonglong bytes) const;
    void drawGroupIndicator(QPainter* p, const QRect& r, int numberOfGroupedImages, bool open) const;
    void drawPanelSideIcon(QPainter* p, bool left, bool right) const;
    void drawDownloadIndicator(QPainter* p, const QRect& r, int itemType) const;
    void drawLockIndicator(QPainter* p, const QRect& r, int lockStatus) const;
    void drawFocusRect(QPainter* p, const QStyleOptionViewItem& option, bool isSelected) const;
    void drawMouseOverRect(QPainter* p, const QStyleOptionViewItem& option) const;
    void prepareFonts();
    void prepareMetrics(int maxWidth);
    void prepareBackground();

    virtual QAbstractItemDelegate* asDelegate();

    // reimplement these in subclasses
    virtual void invalidatePaintingCache();
    virtual void updateSizeRectsAndPixmaps() = 0;

protected:

    ItemViewImportDelegatePrivate* const d_ptr;
    ItemViewImportDelegate(ItemViewImportDelegatePrivate& dd, QObject* const parent);

private:

    Q_DECLARE_PRIVATE(ItemViewImportDelegate)
};

} // namespace Digikam

#endif // ITEMVIEWIMPORTDELEGATE_H
