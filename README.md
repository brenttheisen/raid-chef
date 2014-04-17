# Raid Chef Cookbook

Configures software RAIDs using Linux's mdadm.

## Example

Lets say you wanted to RAID 0 two block devices (`/dev/xvdf` and `/dev/xvdg`) in to one logical devicei (`/dev/md0`).
Your Chef attributes might look like...

````json
{
  "default_attributes": {
    "raid": {
      "devices": {
        "/dev/md0": {
          "level": 0,
          "devices": [ "/dev/xvdf", "/dev/xvdg" ]
        }
      }
    }
}
````

From here you would need to format and mount /dev/md0. To accomplish that consider using the
[filesystem Chef cookbook](http://community.opscode.com/cookbooks/filesystem).

## Credits

This Chef cookbook was derived from the [ephemeral_raid Chef cookbook](http://community.opscode.com/cookbooks/ephemeral_raid). Initially I
tried using it but ended up creating this cookbook because ephemeral_raid has a dependency on the ohai cloud plugin which was painful.

