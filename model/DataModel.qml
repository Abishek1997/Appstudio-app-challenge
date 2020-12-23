import QtQuick 2.5
import QtQuick.LocalStorage 2.12

Item {
    property var db;
    property var imagesDb;
    property var audioDb;

    readonly property alias todos: _.todos
    readonly property alias todoDetails: _.todoDetails
    property alias dispatcher: dataModelConnections.target
    readonly property alias listModel: listModel
    readonly property alias imagePathModel: imagePathModel
    readonly property alias audioPathModel: audioPathModel

    ListModel {
        id: listModel
    }

    ListModel {
        id: imagePathModel
    }

    ListModel {
        id: audioPathModel
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
                }
                result = tx.executeSql('INSERT INTO notesTable VALUES (?,?)', [queryID, JSON.stringify(obj)]);
            })
            controller.readData();
        }

        onDeleteData: {
            print("deleteData()");
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

        onStoreImagePath: {
            print("storing image path..");
            if(!imagesDb){
                return;
            }
            imagesDb.transaction (function(tx){
                var result = tx.executeSql('SELECT * FROM imagesPathTable WHERE id = (?)', queryID);
                var obj = { id: queryID, imagePath: filePath};
                if (result.rows.length === 1){
                    print("Updating existing data...");
                    result = tx.executeSql('DELETE FROM imagesPathTable where id = (?)', queryID);
                }
                result = tx.executeSql('INSERT INTO imagesPathTable VALUES (?,?)', [queryID, JSON.stringify(obj)]);
            });
            controller.readImagePath(queryID);
        }

        onReadImagePath: {
            imagePathModel.clear();
            print ("reading stored image path..");
            if (!imagesDb){
                return;
            }
            imagesDb.transaction( function(tx) {
                print("reading image path data...");
                var result = tx.executeSql("SELECT * FROM imagesPathTable WHERE id = (?)", queryID);
                if (result.rows.length > 0){
                    print('data available...');
                    console.log(`id: ${result.rows[0].id}, path: ${result.rows[0].path}`);
                    imagePathModel.append(JSON.parse(result.rows[0].path));
                    console.log("image listmodel length: ", imagePathModel.count);
                }
            });
        }

        onStoreAudioPath: {
            print("storing audio path..");
            if(!audioDb){
                return;
            }
            audioDb.transaction (function(tx){
                var result = tx.executeSql('SELECT * FROM audioPathTable WHERE id = (?)', queryID);
                var obj = { id: queryID, audioPath: filePath};
                if (result.rows.length === 1){
                    print("Updating existing data...");
                    result = tx.executeSql('DELETE FROM audioPathTable where id = (?)', queryID);
                }
                result = tx.executeSql('INSERT INTO audioPathTable VALUES (?,?)', [queryID, JSON.stringify(obj)]);
            });
            controller.readAudioPath(queryID);
        }

        onReadAudioPath: {
            audioPathModel.clear();
            print("reading stored audio path..");
            if (!audioDb){
                return;
            }
            audioDb.transaction( function(tx){
                print("reading audio path data..");
                var result = tx.executeSql('SELECT * FROM audioPathTable WHERE id = (?)', queryID);
                if(result.rows.length > 0){
                    print('data available..');
                    console.log(`id: ${result.rows[0].id}, path: ${result.rows[0].path}`);
                    audioPathModel.append(JSON.parse(result.rows[0].path));
                    console.log("audio listmodel length:", audioPathModel.count);
                }
            })
        }

        onDeleteImagePath: {
            imagesDb.transaction (function(tx){
                var result = tx.executeSql('SELECT * FROM imagesPathTable WHERE id = (?)', queryID);
                if (result.rows.length === 1){
                    print("Deleting existing data...");
                    result = tx.executeSql('DELETE FROM imagesPathTable where id = (?)', queryID);
                }
            });
            controller.readImagePath(queryID);
        }

        onDeleteAudioPath: {
            audioDb.transaction (function(tx){
                var result = tx.executeSql('SELECT * FROM audioPathTable WHERE id = (?)', queryID);
                if (result.rows.length === 1){
                    print("Deleting existing data...");
                    result = tx.executeSql('DELETE FROM audioPathTable where id = (?)', queryID);
                }
            });
            controller.readAudioPath(queryID);
        }
    }

    function initDatabase(){

        print("initializing notes database, initDatabase()");
        db = LocalStorage.openDatabaseSync("NotesStorage", "1.0", "Stores all the notes entered", 1000);
        db.transaction(function (tx){
            print('Creating notes table if it does not exist...');
            tx.executeSql('CREATE TABLE IF NOT EXISTS notesTable(id NUMBERIC, value TEXT)');
        });
        controller.readData();

        print("initializing images database, initDatabase()");
        imagesDb = LocalStorage.openDatabaseSync("ImagePathStorage", "1.0", "Stores the images path of selected images", 1000);
        imagesDb.transaction( function(tx) {
            print("Creating images table if it does not exist");
            tx.executeSql('CREATE TABLE IF NOT EXISTS imagesPathTable(id NUMERIC, path TEXT)')
        });

        print("initializing audio database, initDatabase()");
        audioDb = LocalStorage.openDatabaseSync("AudioPathStorage", "1.0", "Stores the audio path of selected audio files", 1000);
        audioDb.transaction( function(tx){
            print("Creating audio table if it does not exist");
            tx.executeSql('CREATE TABLE IF NOT EXISTS audioPathTable(id NUMERIC, path TEXT)');
        })
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


