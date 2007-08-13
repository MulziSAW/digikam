/* ============================================================
 *
 * This file is a part of digiKam project
 * http://www.digikam.org
 *
 * Date        : 2004-06-18
 * Description :database album interface.
 *
 * Copyright (C) 2004-2005 by Renchi Raju <renchi@pooh.tam.uiuc.edu>
 * Copyright (C) 2006 by Gilles Caulier <caulier dot gilles at gmail dot com>
 * Copyright (C) 2006-2007 by Marcel Wiesweg <marcel dot wiesweg at gmx dot de>
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

/** @file albumdb.h */

#ifndef ALBUMDB_H
#define ALBUMDB_H

// Qt includes.

#include <QString>
#include <QList>
#include <QStringList>
#include <QDateTime>
#include <QPair>

// KDE includes.

#include <kurl.h>

// Local includes.

#include "albuminfo.h"
#include "databaseaccess.h"
#include "digikam_export.h"

namespace Digikam
{

class DatabaseBackend;
class AlbumDBPriv;

class DIGIKAM_EXPORT AlbumDB
{
public:

    /**
     * This adds a keyword-value combination to the database Settings table
     * if the keyword already exists, the value will be replaced with the new
     * value.
     * @param keyword The keyword
     * @param value The value
     */
    void setSetting(const QString& keyword, const QString& value);

    /**
     * This function returns the value which is stored in the database
     * (table Settings).
     * @param keyword The keyword for which the value has to be returned.
     * @return The values which belongs to the keyword.
     */
    QString getSetting(const QString& keyword);

    // ----------- Album Listing operations -----------
    /**
     * Returns all albums and their attributes in the database
     * @return a list of albums and their attributes
     */
    AlbumInfo::List scanAlbums();

    /**
     * Returns all tags and their attributes in the database
     * @return a list of tags and their attributes
     */
    TagInfo::List scanTags();

    /**
     * Returns all searches from the database
     * @return a list of searches from the database
     */
    SearchInfo::List scanSearches();

    /**
     * Returns all albums in the database with their albumRoot and ID.
     */
    QList<AlbumShortInfo> getAlbumShortInfos();

    // ----------- Operations on PAlbums -----------

    /**
     * Add a new album to the database with the given attributes
     * @param url        url of the album
     * @param caption    the album caption
     * @param date       the date for the album
     * @param collection the album collection
     * @return the id of the album added or -1 if it failed
     */
    int addAlbum(const QString& albumRoot, const QString& url,
                 const QString& caption,
                 const QDate& date, const QString& collection);

    /**
     * Find out the album for a given folder.
     * @param folder The folder for which you want the albumID
     * @param create Create album if it does not exist
     * @return The albumID for that folder,
               or -1 if it does not exist and create is false.
     */
    int  getAlbumForPath(const QString &albumRoot, const QString& path, bool create = true);

    /**
     * List the urls of all subalbums of the album specified by albumRoot and path.
     * @param onlyDirectSubalbums if this is true, only first-level subalbums are returned,
     *                            if false, all levels of children are returned (include subalbums of subalbums).
     */
    QStringList getSubalbumsForPath(const QString &albumRoot, const QString& path, bool onlyDirectSubalbums = true);

    /**
     * Deletes an album from the database. This will not delete the
     * subalbums of the album.
     * @param albumID the id of the album
     */
    void deleteAlbum(int albumID);

    /**
     * Copy the properties of the given srcAlbum to the dstAlbum.
     * Both albums must exist.
     * @return true if the operations succeeds
     */
    bool copyAlbumProperties(int srcAlbumID, int dstAlbumID);

    /**
     * Set a new url for the album. This will not affect the url
     * of the subalbums.
     * @param albumID the id of the album
     * @param url     the new url for the album
     * @param renameSubalbums change the url of all subalbums as well
     */
    void renameAlbum(int albumID, const QString& url, bool renameSubalbums);

    /**
     * Set a caption for the album.
     * @param albumID the id of the album
     * @param caption the new caption for the album
     */
    void setAlbumCaption(int albumID, const QString& caption);

    /**
     * Set a collection for the album.
     * @param albumID    the id of the album
     * @param collection the new collection for the album
     */
    void setAlbumCollection(int albumID, const QString& collection);

    /**
     * Set a date for the album.
     * @param albumID  the id of the album
     * @param date     the date for the album
     */
    void setAlbumDate(int albumID, const QDate& date);

    /**
     * Set the icon for the album.
     * @param albumID the id of the album
     * @param iconID  the id of the icon file
     */
    void setAlbumIcon(int albumID, qlonglong iconID);

    /**
     * Get the fullpath for the album icon file
     * @param albumID the id of the album
     */
    QString getAlbumIcon(int albumID);

    /**
     * Given an albumid, this returns the url for that albumdb
     * @param albumID the id of the albumdb
     * @return the url of the albumdb
     */
    QString getAlbumURL(int albumID);

    /**
     * Returns the lowest/oldest date of all images for that album.
     * @param albumID the id of the album to calculate
     * @return the date.
     */
    QDate getAlbumLowestDate(int albumID);

    /**
     * Returns the highest/newest date of all images for that album.
     * @param albumID the id of the album to calculate
     * @return the date.
     */
    QDate getAlbumHighestDate(int albumID);

    /**
     * Returns the average date of all images for that album.
     * @param albumID the id of the album to calculate
     * @return the date.
     */
    QDate getAlbumAverageDate(int albumID);

    // ----------- Operations on TAlbums -----------

    /**
     * Adds a new tag to the database with given name, icon and parent id.
     * @param parentTagID the id of the tag which will become the new tags parent
     * @param name        the name of the tag
     * @param iconKDE     the name of the icon file (this is filename which kde
     * iconloader can load up)
     * @param iconID      the id of the icon file
     * Note: if the iconKDE parameter is empty, then the iconID parameter is used
     * @return the id of the tag added or -1 if it failed
     */
    int addTag(int parentTagID, const QString& name,
               const QString& iconKDE, qlonglong iconID);

    /**
     * Add tags for the item, create tags with the given paths if they do not yet exist
     * @param tagPaths a list of tag paths
     * @param create create new tags if necessary
     * @returns a list of albumIDs of the tags in tagPaths
     */
    QList<int> getTagsFromTagPaths(const QStringList &tagPaths, bool create);

    /**
     * Get a list of recently assigned tags (only last 6 tags are listed)
     * @return the list of recently assigned tags
     */
    //TODO move to other place (AlbumManager)
    QList<int> getRecentlyAssignedTags() const;

    /**
     * Deletes a tag from the database. This will not delete the
     * subtags of the tag.
     * @param tagID the id of the tag
     */
    void deleteTag(int tagID);

    /**
     * Set a new name for the tag. 
     * @param tagID the id of the tag
     * @param name  the new name for the tag
     */
    void setTagName(int tagID, const QString& name);

    /**
     * Set the icon for the tag.
     * @param tagID the id of the tag
     * @param iconKDE the filename for the kde icon file
     * @param iconID the id of the icon file
     * Note: Only one of the iconKDE or iconID parameters is used.
     * if the iconKDE parameter is empty, then the iconID parameter is used
     */
    void setTagIcon(int tagID, const QString& iconKDE, qlonglong iconID);

    /**
     * Get the icon for the tag.
     * @param tagID the id of the tag
     * @return the path for the icon file. this could be either a simple filename
     * which can be loaded by kiconloader or an absolute filepath to the file
     */
    QString getTagIcon(int tagID);

    /**
     * Set the parent tagid for the tag. This is equivalent to reparenting
     * the tag
     * @param tagID          the id of the tag
     * @param newParentTagID the new parentid for the tag
     */
    void setTagParentID(int tagID, int newParentTagID);

    // ----------- Operations on SAlbums -----------

    /**
     * Add a new search to the database with the given attributes
     * @param name       name of the search
     * @param url        url of the search
     * @return the id of the album added or -1 if it failed
     */
    int addSearch(const QString& name, const KUrl& url);

    /**
     * Updates Search with new attributes
     * @param searchID   the id of the search
     * @param name       name of the search
     * @param url        url of the search
     */
    void updateSearch(int searchID, const QString& name, const KUrl& url);

    /**
     * Delete a search from the database.
     * @param searchID the id of the search
     */
    void deleteSearch(int searchID);

    // ----------- Adding and deleting Items -----------
    /**
     * Put a new item in the database or replace an existing one.
     * @param albumID The albumID where the file is located.
     * @param name The filename
     * @param datetime The datetime to be stored. Should try to let that be
     * the exif-datetime, but if not available the modification date.
     * @param comment The user comment as found in the exif-headers of the 
     * file.
     * @param rating The user rating as found in the iptc-headers of the 
     * file.
     * @param keywords The user keywords as found in the iptc-headers of the 
     * file.
     * @return the id of item added or -1 if it fails
     */
    qlonglong addItem(int albumID, const QString& name,
                    const QDateTime& datetime,
                    const QString& comment,
                    int rating,
                    const QStringList& keywordsList);

    /**
     * Deletes an item from the database.
     * @param albumID The id of the album.
     * @param file The filename of the file to delete.
     */
    void deleteItem(int albumID, const QString& file);

    // ----------- Finding items -----------

    /**
     * Get the imageId of the item
     * @param albumId the albumID of the item
     * @param name the name of the item
     * @return the ImageId for the item, or -1 if it does not exist
     */
    qlonglong getImageId(int albumID, const QString& name);

    enum ItemSortOrder
    {
        NoItemSorting,
        ByItemName,
        ByItemPath,
        ByItemDate,
        ByItemRating
    };

    /**
     * Returns all items for a given albumid. This is used to
     * verify if all items on disk are consistent with the database
     * in the scanlib class.
     * @param albumID The albumID for which you want all items.
     * @return It returns a QStringList with the filenames.
     */
    QStringList getItemNamesInAlbum(int albumID);

    /**
     * Given a albumID, get a list of the url of all items in the album
     * @param  albumID the id of the album
     * @return a list of urls for the items in the album. The urls are the
     * absolute path of the items
     */
    QStringList getItemURLsInAlbum(int albumID, ItemSortOrder order = NoItemSorting);

     /**
      * Given a albumID, get a list of Ids of all items in the album
      * @param  albumID the id of the album
      * @return a list of Ids for the items in the album.
      */
    QList<qlonglong> getItemIDsInAlbum(int albumID);

    /**
     * Given a tagid, get a list of the url of all items in the tag
     * @param  tagID the id of the tag
     * @return a list of urls for the items in the tag. The urls are the
     * absolute path of the items
     */
    QStringList getItemURLsInTag(int tagID, bool recursive = false);

    /**
     * Given a tagID, get a list of Ids of all items in the tag
     * @param  tagID the id of the tag
     * @return a list of Ids for the items in the tag.
     */
    QList<qlonglong> getItemIDsInTag(int tagID, bool recursive = false);

    /**
     * Returns all items in the database without a date. This is used
     * in the scanlib class which tries to find out the date of the 
     * items, so the database holds the date for each item. This was
     * not the case untill the 0.8.0 release.
     * @return The path (starting from albumPath and including the 
     * the filename of all items.
     */
    QStringList getAllItemURLsWithoutDate();

    /**
     * Returns all item in the database and their dates.
     * Items that do not have a valid date set are excluded.
     */
    QList<QPair<QString, QDateTime> > getItemsAndDate();

    // ----------- Item properties -----------

    /**
     * Find the album of an item
     * @param imageID The ID of the item
     * @return The ID of the PAlbum of the item, or -1 if not found
    */
    int getItemAlbum(qlonglong imageID);

    /**
     * Retrieve the name of the item
     * @param imageID The ID of the item
     * @return The name of the item, or a null string if not found
     */
    QString getItemName(qlonglong imageID);

    /**
     * Get the caption for the item
     * @param imageID the id  of the item
     * @return the caption for the item
     */
    QString getItemCaption(qlonglong imageID);

    /**
     * Get the datetime for the item
     * @param imageID the ID of the item
     * @return the datetime for the item
     */
    QDateTime getItemDate(qlonglong imageID);

    /**
     * Get the item rating
     * @param imageID the ID of the item
     * @return the rating for the item
     */
    int getItemRating(qlonglong imageID);

    /**
     * Get item and album info from the image ID
     */
    ItemShortInfo getItemShortInfo(qlonglong imageID);


    /**
     * Set the caption for the item
     * @param imageID the id of the item
     * @param caption the caption for the item
     */
    void setItemCaption(qlonglong imageID, const QString& caption);

    /**
     * Update the date of a item to supplied date
     * @param imageID The ID of the item
     * @param datetime The datetime to be stored. Should try to let that be
     * the exif-datetime, but if not available the modification date.
     * @return It will always return true. Maybe that will change.
     */
    bool setItemDate(qlonglong imageID, const QDateTime& datetime);

    /**
     * Update the rating of a item to supplied value
     * @param imageID The ID of the item
     * @param rating The rating value to be stored.
     */
    void setItemRating(qlonglong imageID, int rating);


    /**
     * Get the datetime for the item
     * @param albumID the albumID of the item
     * @param name    the name of the item
     * @return the datetime for the item
     */
    QDateTime getItemDate(int albumID, const QString& name);

    /**
     * Get the caption for the item
     * @param albumID the albumID of the item
     * @param name    the name of the item
     * @return the caption for the item
     */
    QString getItemCaption(int albumID, const QString& name);


    /**
     * Update the date of a item to supplied date
     * @param albumID The albumID where the file is located.
     * @param name The filename
     * @param datetime The datetime to be stored. Should try to let that be
     * the exif-datetime, but if not available the modification date.
     * @return It will always return true. Maybe that will change.
     */
    bool setItemDate(int albumID, const QString& name,
                     const QDateTime& datetime);

    /**
     * Set the caption for the item
     * @param albumID the albumID of the item
     * @param name    the name of the item
     * @param caption the caption for the item
     */
    void setItemCaption(int albumID, const QString& name, const QString& caption);

    // ----------- Items and their tags -----------

    /**
     * Add a tag for the item
     * @param imageID the ID of the item
     * @param tagID   the tagID for the tag
     */
    void addItemTag(qlonglong imageID, int tagID);

    /**
     * Add a tag for the item
     * @param albumID the albumID of the item
     * @param name    the name of the item
     * @param tagID   the tagID for the tag
     */
    void addItemTag(int albumID, const QString& name, int tagID);

    /**
     * Remove a specific tag for the item
     * @param imageID the ID of the item
     * @param tagID   the tagID for the tag
     */
    void removeItemTag(qlonglong imageID, int tagID);

    /**
     * Remove all tags for the item
     * @param imageID the ID of the item
     */
    void removeItemAllTags(qlonglong imageID);

    /**
     * Get a list of names of all the tags for the item
     * @param imageID the ID of the item
     * @return the list of names of all tags for the item
     */
    QStringList getItemTagNames(qlonglong imageID);

    /**
     * Get a list of IDs of all the tags for the item
     * @param imageID the ID of the item
     * @return the list of IDs of all tags for the item
     */
    QList<int> getItemTagIDs(qlonglong imageID);

    /**
     * Given a set of items (identified by their IDs),
     * this will see if any of the items has a tag.
     * @param imageIDList a list of IDs of the items
     * @return true if at least one of the items has a tag
     */
    bool hasTags(const QList<qlonglong>& imageIDList);

    /**
     * Given a set of items (identified by their IDs),
     * get a list of ID of all common tags
     * @param imageIDList a list of IDs of the items
     * @return the list of common IDs of the given items
     */
    QList<int> getItemCommonTagIDs(const QList<qlonglong>& imageIDList);

    // ----------- Moving and Copying Items -----------

    /**
     * Move the attributes of an item to a different item. Useful when
     * say a file is renamed
     * @param  srcAlbumID the id of the source album
     * @param  dstAlbumID the id of the destination album
     * @param  srcName    the name of the source file
     * @param  dstName    the name of the destination file
     */
    void moveItem(int srcAlbumID, const QString& srcName,
                  int dstAlbumID, const QString& dstName);

    /**
     * Copy the attributes of an item to a different item. Useful when
     * say a file is copied.
     * The operation fails (returns -1) of src and dest are identical.
     * @param  srcAlbumID the id of the source album
     * @param  dstAlbumID the id of the destination album
     * @param  srcName    the name of the source file
     * @param  dstName    the name of the destination file
     * @return the id of item added or -1 if it fails
     */
    int copyItem(int srcAlbumID, const QString& srcName,
                 int dstAlbumID, const QString& dstName);

private:

    friend class Digikam::DatabaseAccess;

    /**
     * Constructor
     */
    AlbumDB(DatabaseBackend *backend);

    /**
     * Destructor
     */
    ~AlbumDB();

private:

    AlbumDBPriv* d;
};

}  // namespace Digikam

#endif /* ALBUMDB_H */
