function change_branch
    set -l branch_name $argv[1]
    set -l root_dir (pwd)
    for git_dir in (/usr/bin/find . -type d -name '.git')
        set -l repo_directory (dirname $git_dir)
        cd $repo_directory
        git checkout $branch_name > /dev/null 2>&1
        cd $root_dir
    end
    echo "Done ✨"
end
