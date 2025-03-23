# Lightspeed commands
function nuorder
    cd $GOPATH/src/gitlab.com/lightspeed-b2b/go/nuorder/
end

function bistro
    cd ~/dev/nuorder/bistro/
end

function bistro_update_deps
    nvm use 16 && \
        rm -rf node_modules/ packages/etl/node_modules/ && \
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
        kubectl get pods -o=custom-columns='POD:.metadata.name,IMAGE:.spec.containers[*].image'
    else
        kubectl get pods -o=custom-columns='POD:.metadata.name,IMAGE:.spec.containers[*].image' | grep $argv 
    end
end

function golint_master_changes
    golangci-lint run -v --new-from-rev=origin/master --issues-exit-code 0 --print-issued-lines=false --out-format code-climate:gl-code-quality-report.json,line-number 
end

# Navigation commands
function take
    mkdir -p $argv; and cd $argv
end
