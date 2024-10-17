This folder contains all your project modules and models.

> NOTE: Git is ignoring the files specified in **.gitignore** file. If your file is not shown, please add additional entries to the .gitignore file.

Example tree structure:

    ├── FirstModule                       # `First` module source code
    │   ├── Descriptor
    │   │   ├── FirstModel.xml            # The model descriptor file (e.g., name, version, etc.)
    │   │   ├── SecondModel.xml
    │   ├── FirstModel                    # `First` model source code with your customizations
    │   │   ├── AxClass                   # Folder containing all the classes.
    │   │   │   ├── FM_Class.xml
    │   │   ├── AxForm                    # Folder containing all the forms.
    │   │   │   ├── FM_Form.xml
    │   │   ├── AxTable                   # Folder containing all the table definitions.
    │   │   │   ├── FM_Table.xml
    │   │   ├── ...    
    │   ├── SecondModel                   # `Second` model source code with your customizations
    │   │   │   ├── AxClass
    │   │   │   │   ├── SM_Class.xml
    │   │   │   ├── AxForm
    │   │   │   │   ├── SM_Form.xml
    │   │   │   ├── AxTable
    │   │   │   │   ├── SM_Table.xml