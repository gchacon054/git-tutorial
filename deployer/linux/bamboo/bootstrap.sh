
skip_git_pull=false
extra_args=""

while [[ $# -gt 0 ]]
do
    key="${1}"
    case ${key} in
        --build_server)
            build_server="${2}"
            shift ;;
        --domain)
            domain="${2}"
            shift ;;
        --domain_username)
            domain_username="${2}"
            shift ;;
        --domain_password)
            domain_password="${2}"
            shift ;;
        --full)
            if [[ "${2}" = true ]];
            then
                extra_args="${extra_args} -full"
            fi
            shift ;;
        --git_remote)
            git_remote="${2}"
            shift ;;
        --git_ref)
            git_ref="${2}"
            shift ;;
        --http_proxy)
            if [[ "${2}" != --* && -n "${2}" ]];
            then
                http_proxy="${2}"
                shift
            fi
            ;;
        --installers_path)
            installers_path="${2}"
            shift ;;
        --repository_root)
            repository_root="${2}"
            shift ;;
        --skip_git_pull)
            if [[ "${2}" != --* && -n "${2}" ]];
            then
                skip_git_pull="${2}"
                shift
            fi
            ;;
        --tunnel_via)
            if [[ "${2}" != --* && -n "${2}" ]];
            then
                tunnel_via="${2}"
                shift
            fi
            ;;
        *)
            if [[ "${1}" == --template_* ]];
            then
                extra_args="${extra_args} -${1#*template_} ${2}"
                shift
            else
                echo "Unknown argument: ${1}"
                exit 1
            fi
            ;;
    esac
    shift
done

echo "Checking out repository onto buildserver: ${build_server}"
