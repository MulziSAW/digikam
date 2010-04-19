/* ============================================================
 *
 * This file is a part of digiKam project
 * http://www.digikam.org
 *
 * Date        : 2010-04-13
 * Description : Dynamically active thread
 *
 * Copyright (C) 2010 by Marcel Wiesweg <marcel dot wiesweg at gmx dot de>
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

#include "dynamicthread.moc"

// Qt includes

#include <QMutex>
#include <QMutexLocker>
#include <QWaitCondition>

// KDE includes

#include <kdebug.h>

// Local includes

#include "threadmanager.h"

namespace Digikam
{

class DynamicThreadPriv : public QRunnable
{
public:

    DynamicThreadPriv(DynamicThread* q) : q(q)
    {
        setAutoDelete(false);

        state = DynamicThread::Inactive;
    };

    virtual void run()
    {
        {
            QMutexLocker locker(&mutex);
            state = DynamicThread::Running;
        }
        emit q->started();
        q->run();
        {
            QMutexLocker locker(&mutex);
            state = DynamicThread::Inactive;
            condVar.wakeAll();
        }
        emit q->finished();
    }

    DynamicThread* const q;

    volatile bool running;

    DynamicThread::State state;

    QMutex         mutex;
    QWaitCondition condVar;
};

DynamicThread::DynamicThread(QObject* parent)
             : QObject(parent), d(new DynamicThreadPriv(this))
{
    setAutoDelete(false);
    ThreadManager::instance()->initialize(this);
}

DynamicThread::~DynamicThread()
{
    delete d;
}

DynamicThread::State DynamicThread::state() const
{
    return d->state;
}

bool DynamicThread::isRunning() const
{
    return d->state == Scheduled || d->state == Running || d->state == Deactivating;
}

bool DynamicThread::isFinished() const
{
    return d->state == Inactive;
}

void DynamicThread::start()
{
    {
        QMutexLocker locker(&d->mutex);
        switch (d->state)
        {
            case Inactive:
            case Deactivating:
                d->state = Scheduled;
                d->running = true;
                break;
            case Running:
            case Scheduled:
                return;
        }
    }
    ThreadManager::instance()->schedule(d);
}

void DynamicThread::stop()
{
    QMutexLocker locker(&d->mutex);
    switch (d->state)
    {
        case Scheduled:
        case Running:
            d->running = false;
            d->state = Deactivating;
            break;
        case Inactive:
        case Deactivating:
            break;
    }
}

void DynamicThread::wait()
{
    QMutexLocker locker(&d->mutex);
    while (d->state != Inactive)
        d->condVar.wait(&d->mutex);
}

bool DynamicThread::runningFlag() const
{
    return d->running;
}

} // namespace Digikam

