#!/bin/bash
# smBuild initialization script published on gist (4:22pm 13-May-18)
#
function syncAzureLabsWithGitSparseCheckout(){
    config=~/.smbuild.conf
    if [ -e "$config" ]; then
        source "$config" $1
        if [ -n "$targetRoot" ];then
            mkdir -p "$targetRoot"
            pushd "$targetRoot"
            echo "Moved to $targetRoot"

            rm -rf $targetRoot/$FolderToCheckout
            
            git init
            echo "Initialized Git"

            git remote add origin $RepoPath
            echo "Added Remote Origin"

            git config core.sparseCheckout true
            echo "Enabled Sparse Checkout"

            git reset --hard
            echo $FolderToCheckout > .git/info/sparse-checkout
            echo "Written to Sparse Checkout File"


            if [ "$latest" == true ];then
                git pull origin $BranchName --depth 1
            else
                git pull origin $BranchName
            fi

            if [ "$ClearGitFolder" == true ];then
            rm -rf "$targetRoot/.git"
            fi

            popd
        else
            echo config data error
        fi
    else
        echo smbuild config data file is missing
    fi
    
}
#map alias
alias ss=syncAzureLabsWithGitSparseCheckout