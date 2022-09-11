# Bash Shell Cheat Sheet
`python -m http://0.0.0.0:8080`

 SQL injection samples
```
mail'--
') drop table students;
CREATE INDEX person_index ON starts (person_id);
```
## General Information 
| | |
| --- | --- |
| OS AND HARDWARE | `uname -a` |
| CURRENT USER LOGIN INFO | `who -a` |
| MACHINE TYPE INFO | `$MACHTYPE` |
| DNS | `cat /etc/resolv.conf` |
| PROCESSES | `ps aux --sort -%mem \| awk {'print $1, $2, $3, $4, $11'}` |
| DATE | `date` |
| HOSTNAME | `hostname -s` |
| CPU | `lscpu \| grep CPU` |
| RAM | `free` |
| DISK | `df -H \| head -2` |
| IP | `ip.addr \| grep inet \| tail -2 \| head -1` |
| EXECUTABLES | `$(find /home -type f -perm 777 2>/dev/null)` |

## Echo

```
echo $ see exit code or previous executed command
echo -e "\nTop 10 Processes" >>$output
```

## If

```
if [ $UID -ne 0 ]; then echo 'no sudo priviledges'; fi
if [ ! -f /home/hola.txt ]; then echo 'hola.txt does not exists'; fi
if [ -d /home/folder ]; then echo 'folder exists'; fi
if [ ! -d ~/research ]; then echo "reseach does not exists"; else echo "research:" && echo $(ls  ~/research) ; fi
```

## List array

```
list=(uno dos tres cuatro cinco)
commands=('date' 'uname -a' 'hostname -s')
```

### Check array

```
echo ${list[@]}
echo ${list[2]}
```

## One cell array

```
lista=('one two three four five')
users=$(ls /home)
```

### Check one cell array

```
echo $lista
echo $users
```

## For Loops

```
for i in ${list[@]}; do echo $i; done
for i in ${commands[@]}; do results=$($i) && echo "$i: $results"; done  Command expansion
for i in {0..2}; do results=$(${commands[i]}) && echo "${commands[i]}: $results"; done  Brace expansion
```

## The next for-loop works only on one cell array

```
for i in $lista; do echo $i; done
for user in $(ls /home); do echo "Username is: $user"; done
```
