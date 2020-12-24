# Appstudio-app-challenge
A simple note-taking application created with ArcGIS app studio in Qt5 framework - QML and javascript

Project Setup:

1. The project is architected with a MVC approach - There is a data model that handles all data and database operations. Multiple UI components with custom reusable widgets
and the controller (signal handlers) which glues the View and the model.

2. The codebase is divided into 4 folders
  
    a. The "model" - contains the datamodel in it, handling database operations and emitting signals and data accordingly to UI delegates
  
    b. The "controller" - contains the Controller component that consists of signals which act as glue tying UI user interaction with the model and vice versa
  
    c. The "view" - contains UI divided into each page - A homepage and the notesDetails page - The view is directly updated by the changes in the datamodel
  
    d. The "widget" - contains custom-built reusable high and low-level UI components
  
    e. The "assets" - contains all images, resources and asset files required externally for the application
  
  
3. Features implemented are
  
    a. Take notes in the form of text, audio recording and pictures - browse from local storage. Add title, description and other information for each note

    b. Displays all the notes in the form of scrollable list view items in the form of pills

    c. Sharing of data with other application is made possible by using Appstudio Framework's clipboard feature

    d. Caching and retrieving all the notes data - including pictures and audio - using LocalStorage SQLite database

    e. Responsive UI

    f. Ability to add/ remove images and audio from each note

    g. Edit and delete notes

4. Features planned but not implemented are
  
    a. Adding labels to each notes - Ex: "personal", "tour", "food", "work", etc.

    b. Adding a feature to change background color for each separate note

    c. Ability to record audio within the application and audio playback - (Could not implement it since I could not find a way to install QtMultimedia 5.15)

5. UI bugs (Tried fixing almost all of it, but fell short on time)
  
    a. Added a scrollview to the "NotesDetailsPage" - but for some reason it does not work as expected and does not scroll.

    b. The first page "HomePage" does not wrap notes horizontally - it extends horizontally

    c. There is a slight UI janking for the first time I select a TextArea in the "NotesDetailsPage"
  
6. Codebase features implemented
  
    a. Modularized codebase by separating concerns at higher level and putting each feature/ concern into its own file and folder

    b. Maximaly tried to reuse code by constructing custom widgets that I have reused

    c. Had a solid MVC approach to the application and adhered to the same approach on most of the codebase and components.
