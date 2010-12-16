/* ============================================================
 *
 * This file is a part of digiKam project
 * http://www.digikam.org
 *
 * Date        : 2005-06-14
 * Description : DImg image loader interface
 *
 * Copyright (C) 2005 by Renchi Raju <renchi@pooh.tam.uiuc.edu>
 * Copyright (C) 2005-2010 by Gilles Caulier <caulier dot gilles at gmail dot com>
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

#include "dimgloader.h"

// Qt includes

#include <QFileInfo>

// KDE includes

#include <kstandarddirs.h>
#include <kcodecs.h>       // for KMD5
#include <kdebug.h>

// Local includes

#include "dimg_p.h"
#include "dmetadata.h"
#include "dimgloaderobserver.h"

namespace Digikam
{

DImgLoader::DImgLoader(DImg* image)
    : m_image(image)
{
    m_loadFlags = LoadAll;
}

void DImgLoader::setLoadFlags(LoadFlags flags)
{
    m_loadFlags = flags;
}

bool DImgLoader::hasLoadedData() const
{
    return (m_loadFlags & LoadImageData) && m_image->m_priv->data;
}

int DImgLoader::granularity(DImgLoaderObserver* observer, int total, float progressSlice)
{
    // Splits expect total value into the chunks where checks shall occur
    // and combines this with a possible correction factor from observer.
    // Progress slice is the part of 100% concerned with the current granularity
    // (E.g. in a loop only the values from 10% to 90% are used, then progressSlice is 0.8)
    // Current default is 1/20, that is progress info every 5%
    int granularity=0;

    if (observer)
    {
        granularity = (int)(( total / (20 * progressSlice)) / observer->granularity());
    }

    return granularity ? granularity : 1;
}

unsigned char*& DImgLoader::imageData()
{
    return m_image->m_priv->data;
}

unsigned int& DImgLoader::imageWidth()
{
    return m_image->m_priv->width;
}

unsigned int& DImgLoader::imageHeight()
{
    return m_image->m_priv->height;
}

bool DImgLoader::imageHasAlpha()
{
    return m_image->hasAlpha();
}

bool DImgLoader::imageSixteenBit()
{
    return m_image->sixteenBit();
}

int DImgLoader::imageBitsDepth()
{
    return m_image->bitsDepth();
}

int DImgLoader::imageBytesDepth()
{
    return m_image->bytesDepth();
}

void DImgLoader::imageSetIccProfile(const IccProfile& profile)
{
    m_image->setIccProfile(profile);
}

QVariant DImgLoader::imageGetAttribute(const QString& key)
{
    return m_image->attribute(key);
}

QString DImgLoader::imageGetEmbbededText(const QString& key)
{
    return m_image->embeddedText(key);
}

void DImgLoader::imageSetAttribute(const QString& key, const QVariant& value)
{
    m_image->setAttribute(key, value);
}

QMap<QString, QString>& DImgLoader::imageEmbeddedText()
{
    return m_image->m_priv->embeddedText;
}

void DImgLoader::imageSetEmbbededText(const QString& key, const QString& text)
{
    m_image->setEmbeddedText(key, text);
}

void DImgLoader::loadingFailed()
{
    if (m_image->m_priv->data)
    {
        delete [] m_image->m_priv->data;
    }

    m_image->m_priv->data   = 0;
    m_image->m_priv->width  = 0;
    m_image->m_priv->height = 0;
}

unsigned char* DImgLoader::new_failureTolerant(size_t size)
{
    try
    {
        return new uchar[size];
    }
    catch (std::bad_alloc& ex)
    {
        kError() << "Failed to allocate chunk of memory of size" << size << ex.what();
        return 0;
    }
}

unsigned short* DImgLoader::new_short_failureTolerant(size_t size)
{
    try
    {
        return new unsigned short[size];
    }
    catch (std::bad_alloc& ex)
    {
        kError() << "Failed to allocate chunk of memory of size" << size << ex.what();
        return 0;
    }
}

bool DImgLoader::readMetadata(const QString& filePath, DImg::FORMAT /*ff*/)
{
    if (! ((m_loadFlags & LoadMetadata) || (m_loadFlags & LoadUniqueHash) || (m_loadFlags & LoadImageHistory)) )
    {
        return false;
    }

    DMetadata metaDataFromFile;

    if (!metaDataFromFile.load(filePath))
    {
        m_image->setMetadata(KExiv2Data());
        return false;
    }

    m_image->setMetadata(metaDataFromFile.data());

    if (m_loadFlags & LoadImageHistory)
    {
        DImageHistory history = DImageHistory::fromXml(metaDataFromFile.getImageHistory());

        HistoryImageId id = createHistoryImageId(filePath, *m_image, metaDataFromFile);
        id.m_type = HistoryImageId::Current;
        history << id;

        m_image->setImageHistory(history);
    }

    return true;
}

// copied from imagescanner.cpp
static QDateTime creationDateFromFilesystem(const QFileInfo& info)
{
    // creation date is not what it seems on Unix
    QDateTime ctime = info.created();
    QDateTime mtime = info.lastModified();

    if (ctime.isNull())
    {
        return mtime;
    }

    if (mtime.isNull())
    {
        return ctime;
    }

    return qMin(ctime, mtime);
}

HistoryImageId DImgLoader::createHistoryImageId(const QString& filePath, const DImg& image, const DMetadata& metadata)
{
    QFileInfo file(filePath);

    if (!file.exists())
    {
        return HistoryImageId();
    }

    HistoryImageId id(metadata.getImageUniqueId());

    QDateTime dt = metadata.getImageDateTime();

    if (dt.isNull())
    {
        dt = creationDateFromFilesystem(file);
    }

    id.setCreationDate(dt);
    id.setFileName(file.fileName());
    id.setPathOnDisk(file.path());
    id.setUniqueHash(uniqueHashV2(filePath, &image), file.size());

    return id;
}

bool DImgLoader::saveMetadata(const QString& filePath)
{
    DMetadata metaDataToFile(filePath);
    metaDataToFile.setData(m_image->getMetadata());
    return metaDataToFile.applyChanges();
}

bool DImgLoader::checkExifWorkingColorSpace()
{
    DMetadata metaData(m_image->getMetadata());
    IccProfile profile = metaData.getIccProfile();

    if (!profile.isNull())
    {
        m_image->setIccProfile(profile);
        return true;
    }

    return false;
}

void DImgLoader::updateFromFile(QFile& file, QCryptographicHash& hash, const int size)
{
    char databuf[size];
    int readlen = 0;

    if ( ( readlen = file.read( databuf, size ) ) > 0 )
    {
        hash.addData( databuf, readlen );
    }
}


QByteArray DImgLoader::uniqueHashV2(const QString& filePath, const DImg* img)
{
    QFile file( filePath );
    if (!file.open( QIODevice::Unbuffered | QIODevice::ReadOnly ))
    {
        return QByteArray();
    }

    QCryptographicHash md5(QCryptographicHash::Md5);

    // Specified size: 100 kB; but limit to file size
    const qint64 specifiedSize = 100 * 1024; // 100 kB
    qint64 size = qMin(file.size(), specifiedSize);

    // Read first 100 kB
    updateFromFile(file, md5, size);
    // Read last 100 kB
    file.seek(file.size() - size);
    updateFromFile(file, md5, size);

    QByteArray hash = md5.result().toHex();

    if (img && !hash.isNull())
    {
        const_cast<DImg*>(img)->setAttribute("uniqueHashV2", hash);
    }

    return hash;
}


QByteArray DImgLoader::uniqueHash(const QString& filePath, const DImg& img, bool loadMetadata)
{
    QByteArray bv;

    if (loadMetadata)
    {
        DMetadata metaDataFromFile(filePath);
#if KEXIV2_VERSION >= 0x010000
        bv = metaDataFromFile.getExifEncoded();
#else
        bv = metaDataFromFile.getExif();
#endif
    }
    else
    {
        DMetadata metaDataFromImage(img.getMetadata());
#if KEXIV2_VERSION >= 0x010000
        bv = metaDataFromImage.getExifEncoded();
#else
        bv = metaDataFromImage.getExif();
#endif
    }

    // Create the unique ID

    KMD5 md5;

    // First, read the Exif data into the hash
    md5.update( bv );

    // Second, read in the first 8KB of the file
    QFile qfile( filePath );

    char databuf[8192];
    int readlen = 0;
    QByteArray size = 0;

    QByteArray hash;

    if ( qfile.open( QIODevice::Unbuffered | QIODevice::ReadOnly ) )
    {
        if ( ( readlen = qfile.read( databuf, 8192 ) ) > 0 )
        {
            md5.update( databuf, readlen );
            md5.update( size.setNum( qfile.size() ) );
            hash = md5.hexDigest();
        }
    }

    if (!hash.isNull())
    {
        const_cast<DImg&>(img).setAttribute("uniqueHash", hash);
    }

    return hash;
}

}  // namespace Digikam
