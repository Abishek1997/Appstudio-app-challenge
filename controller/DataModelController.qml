import QtQuick 2.0

Item {
    signal readData()
    signal storeData(int queryID, string title, string notes)
    signal deleteData(int queryID)
}
