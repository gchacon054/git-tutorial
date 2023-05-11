
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

echo "Checking out repository onto buildserver: ${build_server}"
