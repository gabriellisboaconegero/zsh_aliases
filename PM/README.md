# Project Menager

## TODO'S
- [ ] [Push Project](#push-project)
- [ ] [Set Project](#set-project)
- [ ] [Remove Project](#remove-project)
- [ ] [Push and Set](#push-and-set)
- [ ] [Calbacks](#calbacks)

## CRUD
- ### Push project
  | Alias | Description|
  |:---   |    :---    |
  | <input type="checkbox" checked disabled> `pupro`|Pushes `PWD` to projects file.|
  |<input type="checkbox" disabled>`pupro [dir]`|Pushes `dir` to projects files|
- ### Set project
  | Alias | Description|
  |:---   |    :---    |
  |<input type="checkbox" checked disabled>`sepro`|Set `PWD` to Current Working Project.|
  |<input type="checkbox" disabled>`sepro [dir/id]`|Set `dir/id` to Current Working Project.|
  |<input type="checkbox" checked disabled>`setpro`|Open [list of projects](#set-list) and choose one of them.<br>Using the keyboard directions keys|
- ### Remove Project
  | Alias | Description|
  |:---   |    :---    |
  |<input type="checkbox" checked disabled>`rmpro`|Remove `PWD` of projects file.|
  |<input type="checkbox" disabled>`rmpro [dir/id]`|Remove `dir/id` of projects file.|
- ### Push and Set
  | Alias | Description|
  |:---   |    :---    |
  |<input type="checkbox" checked disabled>`setpu`|Pushes `PWD` to projects file and<br>set `PWD` to Current Working Project.|
  |<input type="checkbox" disabled>`setpu [dir/id]`|Pushes `dir/id` to projects files and<br>set `dir/id` to Current Working Project.|
- ### Calbacks
  | Alias | Description|
  |:---   |    :---    |
  |<input type="checkbox" disabled>`setcal [cal/script]`|Set the `cal/script` calback<br> to the Current  Working Porject|
  |<input type="checkbox" disabled>`setcal[cal/script] [dir/id]`|Set the `cal/script` calback<br> to the `dir/id` project|

## List of projects
- ### List : `prolis`
  ```shell
  $ prolis
  -------------------------
  [1] -> /path/to/project_1
  [2] -> /path/to/project_1
  [3] -> /path/to/project_1
  [4] -> /path/to/project_1
  -------------------------
  $ 
  ```
- ### Set list : `setpro`
  ```shell
  $ setpro
  Use arrow keys to choose
  -> [1] /path/to/project_1
     [2] /path/to/project_1
     [3] /path/to/project_1
     [4] /path/to/project_1
  ```