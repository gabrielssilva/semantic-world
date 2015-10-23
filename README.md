# Semantic World
It is a generic world implemented in Prolog. You can register your facts and query the world to know the answers.

## Syntax
1. OBJ1 has OBJ2
2. OBJ1 ACTION, which results on addition of OBJ2
3. OBJ1 ACTION, which results on remotion of OBJ2

Where OBJ and ACTION are variable that you can edit, and the rest of the phrase must match the exact syntax.

The first fact adds two objects and the relation between them. The second and third adds an action to an object, and a consequence to that action. If you use the addtion rule this action will add the OBJ2 to OBJ1 as a relations "has". Otherwise, the action will remove OBJ2 from OBJ1.

## How to use
First, you can fill the file initial.in with some facts, that will be read when you execute the program.

```bash
$ swipl -s semantic_world
?- read_base.
```
