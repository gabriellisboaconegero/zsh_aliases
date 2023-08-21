# Project Menager

## TODO'S
- [ ] [Push Project](#push-project)
- [x] [Set Project](#set-project)
- [x] [Remove Project](#remove-project)
- [x] [Push and Set](#push-and-set)
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
  |<input type="checkbox" checked disabled>`sepro [id]`|Set `dir/id` to Current Working Project.|
  |<input type="checkbox" checked disabled>`setpro`|Open [Set list](#set-list) and choose one of them.<br>Using the keyboard directions keys|
- ### Remove Project
  | Alias | Description|
  |:---   |    :---    |
  |<input type="checkbox" checked disabled>`rmpro`|Open [Remove List](#remove-list) and choose one of them.<br>Using the keyboard directions keys|
  |<input type="checkbox" checked disabled>`rmpro [id]`|Remove `id` of projects file.|
- ### Push and Set
  | Alias | Description|
  |:---   |    :---    |
  |<input type="checkbox" checked disabled>`setpu`|Pushes `PWD` to projects file and<br>set `PWD` to Current Working Project.|
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
- ### Remove list : `rmpro`
  ```shell
  $ rmpro
  Use arrow keys to choose
  -> [1] /path/to/project_1
     [2] /path/to/project_1
     [3] /path/to/project_1
     [4] /path/to/project_1
  ```