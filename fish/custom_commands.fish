# Lightspeed commands
function nuorder
    cd $GOPATH/src/gitlab.com/lightspeed-b2b/go/nuorder/
end

function bistro
    cd ~/dev/nuorder/bistro/
end

function bistro_update_deps
    nvm use 16.7.0 && \
        rm -rf node_modules/ packages/*/node_modules/ && \
        npm i && npx lerna bootstrap && \
        npx lerna run build --scope @nuorder/analytics-aggregator && \
        npx lerna run build --scope @nuorder/core && \
        npm run format-locks
end

function universal-catalog-ui
    cd ~/dev/nuorder/universal-catalog-ui/
end

function nimages
    if test -z $argv
        set lines (kubectl get pods -o=custom-columns='POD:.metadata.name,IMAGE:.spec.containers[*].image,CREATED:.metadata.creationTimestamp')
    else 
        set lines (kubectl get pods -o=custom-columns='POD:.metadata.name,IMAGE:.spec.containers[*].image,CREATED:.metadata.creationTimestamp' | grep $argv)
    end

    # Initialize max lengths
    set max_pod_length 0
    set max_image_length 0
    set max_elapsed_length 0

    # First pass to calculate maximum lengths
    for line in $lines
        set pod (echo $line | awk '{print $1}')
        set image (echo $line | awk '{print $2}')
        set date_str (echo $line | awk '{print $3}')

        # Update max lengths
        set pod_length (string length $pod)
        set image_length (string length $image)

        if test $pod_length -gt $max_pod_length
            set max_pod_length $pod_length
        end

        if test $image_length -gt $max_image_length
            set max_image_length $image_length
        end
    end

    # Add extra spaces for titles
    set max_pod_length (math "$max_pod_length + 2")
    set max_image_length (math "$max_image_length + 2")
    set max_elapsed_length 12  # Fixed width for elapsed time column

    # Print the header with bold titles
    printf "%-*s %-*s %-*s\n" $max_pod_length "POD NAME" $max_image_length "IMAGE NAME" $max_elapsed_length "STARTED AGO"

    # Second pass to print formatted output
    for line in $lines
        set pod (echo $line | awk '{print $1}')
        set image (echo $line | awk '{print $2}')
        set date_str (echo $line | awk '{print $3}')

        # Convert the date string to epoch time
        set created (date -j -f "%Y-%m-%dT%H:%M:%SZ" "$date_str" +%s)

        # Get the current time in epoch
        set now (date +%s)

        # Calculate elapsed time
        set elapsed (math "$now - $created")

        # Convert elapsed time to hours, minutes, and seconds
        set hours (math "$elapsed / 3600")
        set minutes (math "($elapsed % 3600) / 60")
        set seconds (math "$elapsed % 60")

        # Round to one decimal place using printf
        set hours (printf "%.0f" $hours)
        set minutes (printf "%.0f" $minutes)
        set seconds (printf "%.0f" $seconds)

        # Construct a shorter format for elapsed time
        set elapsed_time ""

        if test $hours -gt 0
            set elapsed_time "$hours"h
        end

        if test $minutes -gt 0
            if test $elapsed_time != ""
                set elapsed_time "$elapsed_time"
            end
            set elapsed_time "$elapsed_time$minutes"m
        end

        if test $seconds -gt 0
            if test $elapsed_time != ""
                set elapsed_time "$elapsed_time"
            end
            set elapsed_time "$elapsed_time$seconds"s
        end

        # Print the result with fixed-width formatting
        printf "%-*s %-*s %-*s\n" $max_pod_length $pod $max_image_length $image $max_elapsed_length $elapsed_time
    end
end

function golint_master_changes
    golangci-lint run -v --new-from-rev=origin/master --issues-exit-code 0 --print-issued-lines=false --out-format code-climate:gl-code-quality-report.json,line-number 
end

function uc_elc_stg
    set ls_env "stg"; kubectl port-forward --namespace $ls_env-universal-search-eck svc/$ls_env-universal-search-es-internal-lb 9202:9200 --context ls-b2b-eck-network-us-west1-$ls_env
end


function uc_elc_stg_new
    set ls_env "stg"; kubectl port-forward --namespace $ls_env-universal-search-1-eck svc/$ls_env-universal-search-1-es-internal-lb 9206:9200 --context ls-b2b-eck-network-us-west1-$ls_env
end

function uc_elc_prod
    set ls_env "prd"; kubectl port-forward --namespace $ls_env-universal-search-eck svc/$ls_env-universal-search-es-internal-lb 9204:9200 --context ls-b2b-eck-network-us-west1-$ls_env
end

function set_nuorder_token
    export NUORDER_SERVICE_ACCOUNT_TOKEN=$(kubectl --namespace=staging-go get secret service-client-access-token -o jsonpath=\{.data.token\} | base64 --decode)
end

function proxy_postgres_uc 
    CSQL_PROXY_INSTANCE_CONNECTION_NAME=nuorder-staging:us-west1:staging-postgres-universal-catalog cloud_sql_proxy --auto-iam-authn
end

# Navigation commands
function take
    mkdir -p $argv; and cd $argv
end
