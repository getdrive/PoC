#!/bin/bash
# ================================================================================
function get_version()
{
  # try to get the exact version first from the following path
  out=$(curl -m 30 -k -X GET -L "$site/mifs/c/windows/api/v2/device/registration" 2>/dev/null)
  ver=$(echo "$out" |& grep '<script type="text/javascript"' | head -1 | cut -d "?" -f2 | cut -d '"' -f1)

  if [[ "$ver" == "" ]]
  then
    # echo "[-] $site exact version check failed"       # commented out just to have single output line for every script run

    out=$(curl -m 30 -k -X GET -L "://$site" 2>/dev/null)       # check the mobileiron title page for copyright
    copyright=$(echo "$out" |& grep 'Copyright &copy' | tail -1)            # new 2023 style copyright?
    if [[ "$copyright" == "" ]]
    then
      copyright=$(echo "$out" |& grep 'copyright' | tail -1 | awk '{ print $3,$4,$5 }')     # old style copyright
    fi
  fi
}
# ================================================================================

# ================================================================================
# check if the site is vulnerable based on exact version or copyright
# ================================================================================
function check_if_vulnerable()
{
  if [[ "$ver" != "" ]]        # exact known version
  then
    # version 11.10.x and diffrent from 11.10.0.2, possibly newer version - 11.10.0.3
    if [[ "$ver" =~ "11.10.0" && ! "$ver" =~ "11.10.0.2" ]]
    then
      last=$(echo $ver | awk '{ print $2 }' | cut -d '.' -f4)       # last "octet"
      greater=$(echo "$last > 2" | bc)      # is the last "octet" in the version greater than 2 (version 11.10.0.2)

      if [[ "$greater" == 1 ]]
      then
        echo "[-] $site not vulnerable ($ver)"
      else
        echo "[+] $site is running version $ver which is vulnerable!"
      fi

    elif [[ "$ver" =~ "11.8.1.1" || "$ver" =~ "11.9.1.1" || "$ver" =~ "11.10.0.2" ]]    # generic check on patched versions
    then
      echo "[-] $site not vulnerable ($ver)"
    else
      echo "[+] $site is running version $ver which is vulnerable!"
    fi 
  else                         # unknown exact version
    if [[ "$copyright" != "" ]]
    then
      if [[ "$copyright" =~ "2023" ]]
      then
        echo "[-] $site could be patched, unable to determine exact version. Copyright year is 2023 which could indicate installed patch."
      else
        echo "[+] $site looks to be vulnerable based on copyright year"
      fi
    else
      echo "[-] $site both the exact version and copyright are unknown, unable to determine if the site is vulnerable"
    fi 
  fi
}
# ================================================================================

# ================================================================================
# the actual vulnerable path is /mifs/aad/... , eg /mifs/aad/api/v2/admins/users
# the script does not check if the actual API is vulnerable - you can do this by hand
# or just extend the script :)
# ================================================================================
site=$1
get_version
check_if_vulnerable


