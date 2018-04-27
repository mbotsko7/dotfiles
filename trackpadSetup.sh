search='Synaptics TouchPad'
ids=$(xinput --list | awk -v search="$SEARCH" \
    '$0 ~ search {match($0, /id=[0-9]+/);\
                  if (RSTART) \
                    print substr($0, RSTART+3, RLENGTH-3)\
                 }'\
     )

for i in $ids
do
    xinput set-prop $i 'libinput Click Method Enabled' {0, 1}
    xinput set-prop $i 'libinput Natural Scrolling Enabled' 1
    xinput set-prop $i 'libinput Accel Speed' -0.3
    xinput set-prop $i 'libinput Horizontal Scroll Enabled' 0
done

search='Elan TrackPoint'
ids=$(xinput --list | awk -v search="$SEARCH" \
    '$0 ~ search {match($0, /id=[0-9]+/);\
                  if (RSTART) \
                    print substr($0, RSTART+3, RLENGTH-3)\
                 }'\
     )

for i in $ids
do
    xinput set-prop $i 'libinput Accel Profile Enabled' {0, 1}
    xinput set-prop $i 'libinput Accel Speed' 0.5
done
