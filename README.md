# ny-tree
This is New Year present for the community by Percona Support team: a stored function that draws a New Year Tree. See also https://en.wikipedia.org/wiki/New_Year_tree

## Usage:

1. Import ny_tree.sql into a MySQL database
2. Call function ny_tree as SELECT ny_tree(level, light_symbol) where level is number of levels in the tree and light_symbol is any symbol that represents New Year Tree light.

```
$ mysql ny_tree -e "select ny_tree(3, '*')" --vertical --skip-column-names -s
*************************** 1. row ***************************

   /\
  /__\
  /* \
 /____\
 /  * \
/______\
   ||
$ mysql ny_tree -e "select ny_tree(5, '*')" --vertical --skip-column-names -s
*************************** 1. row ***************************

     /\
    /__\
    /  \
   /____\
   /   *\
  /______\
  / *  **\
 /________\
 /*   * * \
/__________\
     ||
```

You can use any Unicode symbol for your lights having it has ssame witdth as the space symbol:

```
$ mysql ny_tree -e "select ny_tree(4, '✵')" --vertical --skip-column-names -s
*************************** 1. row ***************************

    /\
   /__\
   /✵ \
  /____\
  /✵ ✵ \
 /______\
 /✵✵✵  ✵\
/________\
    ||
$ mysql ny_tree -e "select ny_tree(4, '✩')" --vertical --skip-column-names -s
*************************** 1. row ***************************

    /\
   /__\
   / ✩\
  /____\
  /✩✩✩ \
 /______\
 /✩✩✩ ✩ \
/________\
    ||
```
