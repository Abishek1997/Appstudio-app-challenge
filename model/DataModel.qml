import QtQuick 2.5
import QtQuick.LocalStorage 2.12

Item {
    property var db;
    readonly property alias todos: _.todos
    readonly property alias todoDetails: _.todoDetails
    property alias dispatcher: dataModelConnections.target
    readonly property alias listModel: listModel

    ListModel {
        id: listModel
    }

    Connections{
        id: dataModelConnections
        onReadData: {
            _.todos = [];
            _.todoDetails = ({})
            listModel.clear();

            print("readData()")
            if (!db) {
                return;
            }
            db.transaction( function(tx) {
                print("reading data...");
                var result = tx.executeSql("SELECT * FROM notesTable");
                if (result.rows.length > 0){
                    print('data available...');
                    for (var i = 0; i < result.rows.length; i++){
                        console.log(`id: ${result.rows[i].id}, value: ${result.rows[i].value}`)
                        _.todos.push(JSON.parse(result.rows[i].value));
                        listModel.append(JSON.parse(result.rows[i].value));
                    }
                    console.log("listmodel length: ", listModel.count)
                }
            })
        }

        onStoreData: {
            print("storeData()")
            if (!db){
                return;
            }
            db.transaction( function(tx) {
                print("writing data...");
                var result = tx.executeSql('SELECT * FROM notesTable WHERE id = (?)', queryID);
                var obj = { id: queryID, titleText: title, notesText: notes };
                if (result.rows.length === 1){
                    print("Updating existing data...");
                    result = tx.executeSql('DELETE FROM notesTable where id = ?', queryID);
                    controller.readData();
                }
                result = tx.executeSql('INSERT INTO notesTable VALUES (?,?)', [queryID, JSON.stringify(obj)]);
            })
            controller.readData();
        }

        onDeleteData: {
            print("deleteData()")
            if (!db){
                return;
            }
            db.transaction ( function(tx) {
                print("deleting data...");
                var result = tx.executeSql('DELETE FROM notesTable WHERE id = (?)', queryID);
                if (result.rows.length === 1){
                    print("Deleted successfully...");
                } else{
                    print("Data not found..")
                }
            })
            controller.readData();
        }
    }

    function initDatabase(){

        print("initializing database, initDatabase()");
        db = LocalStorage.openDatabaseSync("NotesStorage", "1.0", "Stores all the notes entered", 1000);
        db.transaction(function (tx){
            print('Creating table if it does not exist...');
            tx.executeSql('CREATE TABLE IF NOT EXISTS notesTable(id NUMBERIC, value TEXT)');
        });
        controller.readData();
    }

//    function clearDatabase(){
//        print("Dropping table...")
//        db.transaction(function (tx){
//            print('Creating table if it does not exist...');
//            tx.executeSql('DROP TABLE notesTable');
//        });
//    }

    Component.onCompleted: {
        initDatabase();
    }

//    Component.onDestruction: {
//        clearDatabase();
//    }

    Item {
        id: _
        property var todos: []
        property var todoDetails: ({})
      }
}


