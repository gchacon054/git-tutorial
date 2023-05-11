################################################################################
##
## Common bootstrap for all bamboo jobs:
##   1) Git checkout to build server
##   2) Salt provision build server
##
## In Bamboo, the task should be a shell script file task with the following
## arguments (sorted alphabetically):
##
##   --build_server    ${bamboo.build_server}
##   --domain          ${bamboo.domain}
##   --domain_username ${bamboo.domain_username}
##   --domain_password ${bamboo.domain_password}
##   --full            ${bamboo.full}
##   --git_remote      ${bamboo.git_remote}
##   --git_ref         ${bamboo.planRepository.1.revision}
##   --http_proxy      ${bamboo.http_proxy}
##   --installers_path ${bamboo.installers_path}
##   --repository_root ${bamboo.repository_root}
##   --skip_git_pull   ${bamboo.skip_git_pull}
##   --tunnel_via      ${bamboo.tunnel_via}
##
################################################################################

#source "$(dirname "${0}")/../utilities.sh"
#preserve_script_log /var/log/deploy/build.log

skip_git_pull=false
extra_args=""

while [[ $# -gt 0 ]]
do
    key="${1}"
    case ${key} in
        --build_server)
            build_server="${2}"
            shift ;;

        --tunnel_via)
            if [[ "${2}" != --* && -n "${2}" ]];
            then
                tunnel_via="${2}"
                shift
            fi
            ;;
        *)
    esac
    shift
done

echo "Checking out repository onto buildserver:" "$build_server"
