import QtQuick 2.0

Item {
    signal readData()
    signal storeData(int queryID, string title, string notes)
    signal deleteData(int queryID)
    signal storeImagePath(int queryID, string filePath)
    signal readImagePath(int queryID)
}
