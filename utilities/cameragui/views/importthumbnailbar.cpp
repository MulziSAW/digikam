#include "importthumbnailbar.h"

// KDE includes

#include <kdebug.h>

// Local includes

#include "importsettings.h"
#include "importdelegate.h"
#include "importfiltermodel.h"

namespace Digikam
{

//class ImportThumbnailDelegate;

class ImportThumbnailBar::ImportThumbnailBarPriv
{
public:

    ImportThumbnailBarPriv()
    {
        scrollPolicy     = Qt::ScrollBarAlwaysOn;
        duplicatesFilter = 0;
    }

    Qt::ScrollBarPolicy            scrollPolicy;
    NoDuplicatesImportFilterModel* duplicatesFilter;
};

ImportThumbnailBar::ImportThumbnailBar(QWidget* parent)
    : ImportCategorizedView(parent), d(new ImportThumbnailBarPriv())
{
    setItemDelegate(new ImportThumbnailDelegate(this));
    setSpacing(3);
    setUsePointingHandCursor(false);
    setScrollStepGranularity(5);
    setScrollBarPolicy(Qt::ScrollBarAlwaysOn);

    setDragEnabled(true);
    setAcceptDrops(true);
    setDropIndicatorShown(false);

    //TODO: Implement Import Tool settings
    //setToolTipEnabled(ImportSettings::instance()->showToolTipsIsValid());

    connect(ImportSettings::instance(), SIGNAL(setupChanged()),
            this, SLOT(slotSetupChanged()));

    slotSetupChanged();
    setFlow(LeftToRight);
}

ImportThumbnailBar::~ImportThumbnailBar()
{
    delete d;
}

void ImportThumbnailBar::setModelsFiltered(ImportImageModel* model, ImportSortFilterModel* filterModel)
{
    if (!d->duplicatesFilter)
    {
        d->duplicatesFilter = new NoDuplicatesImportFilterModel(this);
    }

    d->duplicatesFilter->setSourceFilterModel(filterModel);
    ImportCategorizedView::setModels(model, d->duplicatesFilter);
}

//TODO: Implement rating in Import Tool
//void ImportThumbnailBar::installRatingOverlay()
//{
//    ImageRatingOverlay* ratingOverlay = new ImageRatingOverlay(this);
//    addOverlay(ratingOverlay);

//    connect(ratingOverlay, SIGNAL(ratingEdited(QList<QModelIndex>,int)),
//            this, SLOT(assignRating(QList<QModelIndex>,int)));
//}

void ImportThumbnailBar::slotDockLocationChanged(Qt::DockWidgetArea area)
{
    if (area == Qt::LeftDockWidgetArea || area == Qt::RightDockWidgetArea)
    {
        setFlow(TopToBottom);
    }
    else
    {
        setFlow(LeftToRight);
    }

    scrollTo(currentIndex());
}

void ImportThumbnailBar::setScrollBarPolicy(Qt::ScrollBarPolicy policy)
{
    if (policy == Qt::ScrollBarAsNeeded)
    {
        // Delegate resizing will cause endless relayouting, see bug #228807
        kError() << "The Qt::ScrollBarAsNeeded policy is not supported by ImportThumbnailBar";
    }

    d->scrollPolicy = policy;

    if (flow() == TopToBottom)
    {
        setVerticalScrollBarPolicy(d->scrollPolicy);
        setHorizontalScrollBarPolicy(Qt::ScrollBarAlwaysOff);
    }
    else
    {
        setHorizontalScrollBarPolicy(d->scrollPolicy);
        setVerticalScrollBarPolicy(Qt::ScrollBarAlwaysOff);
    }
}

void ImportThumbnailBar::setFlow(QListView::Flow flow)
{
    setWrapping(false);

    ImportCategorizedView::setFlow(flow);

    ImportThumbnailDelegate* del = static_cast<ImportThumbnailDelegate*>(delegate());
    del->setFlow(flow);

    // Reset the minimum and maximum sizes.
    setMinimumSize(QSize(0, 0));
    setMaximumSize(QSize(QWIDGETSIZE_MAX, QWIDGETSIZE_MAX));

    // Adjust minimum and maximum width to thumbnail sizes.
    if (flow == TopToBottom)
    {
        int viewportFullWidgetOffset = size().width() - viewport()->size().width();
        setMinimumWidth(del->minimumSize() + viewportFullWidgetOffset);
        setMaximumWidth(del->maximumSize() + viewportFullWidgetOffset);
    }
    else
    {
        int viewportFullWidgetOffset = size().height() - viewport()->size().height();
        setMinimumHeight(del->minimumSize() + viewportFullWidgetOffset);
        setMaximumHeight(del->maximumSize() + viewportFullWidgetOffset);
    }

    setScrollBarPolicy(d->scrollPolicy);
}

void ImportThumbnailBar::slotSetupChanged()
{
    setToolTipEnabled(ImportSettings::instance()->showToolTipsIsValid());
    setFont(ImportSettings::instance()->getIconViewFont());

    ImportCategorizedView::slotSetupChanged();
}

//TODO: Implement rating in Import Tool
//void ImportThumbnailBar::assignRating(const QList<QModelIndex>& indexes, int rating)
//{
//    FileActionMngr::instance()->assignRating(imageSortFilterModel()->imageInfos(indexes), rating);
//}

bool ImportThumbnailBar::event(QEvent* e)
{
    // reset widget max/min sizes
    if (e->type() == QEvent::StyleChange)
    {
        setFlow(flow());
    }

    return ImportCategorizedView::event(e);
}

QModelIndex ImportThumbnailBar::nextIndex(const QModelIndex& index) const
{
    return importFilterModel()->index(index.row() + 1, 0);
}

QModelIndex ImportThumbnailBar::previousIndex(const QModelIndex& index) const
{
    return importFilterModel()->index(index.row() - 1, 0);
}

QModelIndex ImportThumbnailBar::firstIndex() const
{
    return importFilterModel()->index(0, 0);
}

QModelIndex ImportThumbnailBar::lastIndex() const
{
    return importFilterModel()->index(importFilterModel()->rowCount() - 1, 0);
}

} // namespace Digikam
