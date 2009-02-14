/* ============================================================
 *
 * This file is a part of digiKam project
 * http://www.digikam.org
 *
 * Date        : 2008-11-24
 * Description : Available batch tools list.
 *
 * Copyright (C) 2008-2009 by Gilles Caulier <caulier dot gilles at gmail dot com>
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

#ifndef TOOLS_LIST_H
#define TOOLS_LIST_H

// Qt includes.

#include <QTreeWidget>
#include <QWidget>
#include <QPixmap>

// Local includes.

#include "batchtool.h"
#include "batchtoolsmanager.h"

namespace Digikam
{

class ToolListPriv;

class ToolListViewGroup : public QTreeWidgetItem
{

public:


    ToolListViewGroup(QTreeWidget *parent, BatchTool::BatchToolGroup group);
    virtual ~ToolListViewGroup();

    BatchTool::BatchToolGroup toolGroup() const;

private:

    BatchTool::BatchToolGroup  m_group;
};

// -------------------------------------------------------------------------

class ToolListViewItem : public QTreeWidgetItem
{

public:


    ToolListViewItem(ToolListViewGroup *parent, BatchTool* tool);
    virtual ~ToolListViewItem();

    BatchTool* tool() const;

private:

    BatchTool *m_tool;
};

// -------------------------------------------------------------------------

class ToolsListView : public QTreeWidget
{
    Q_OBJECT

public:

    ToolsListView(QWidget *parent);
    virtual ~ToolsListView();

    BatchToolsList toolsList();

    void addTool(BatchTool* tool);
    bool removeTool(BatchTool* tool);

private:

    bool findTool(BatchTool* tool);
    ToolListViewGroup* findToolGroup(BatchTool::BatchToolGroup group);

    void startDrag(Qt::DropActions supportedActions);
    QStringList mimeTypes() const;
    QMimeData* mimeData(const QList<QTreeWidgetItem*> items) const;
};

}  // namespace Digikam

#endif // TOOLS_LIST_H