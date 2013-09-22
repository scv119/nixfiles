#################################
####    fast go dir #############
#################################

go_idx_path=~/.go_idx
alias_idx_path=~/.alias_go_dix
if [ -f $go_idx_path ];then
    true
else
    touch $go_idx_path
fi

if [ -f $alias_idx_path ]; then
    true
else 
    touch $alias_idx_path
fi

__alias_add(){
    source $1 
}

__alias_add $alias_idx_path


shownames(){
    sed -e 's/=[^=]*$//g' $1
}


aliasadd(){
    local key=''
    local command=''
    if [ $# -lt 2 ];then
        echo "usage aliasadd KEY COMMAND.."
    else
        for para in $@;  
        do
            if [ ${#key} -eq 0 ];
            then
                key=$para
            else
                command=$command' '$para
            fi
        done
    fi

    if shownames $alias_idx_path |grep $key >>/dev/null; 
    then
        echo "$key is already occupied"
        return
    fi

    echo "alias $key='$command'" >> $alias_idx_path 
    __alias_add $alias_idx_path
}

aliaslist(){
    cat $alias_idx_path
}


goadd(){
    local bmpath=$(pwd)
    local bmname=''
    if [ $# -eq 1 ];then
        bmname=$1
    else
        echo "usage goadd KEY"
    fi
#    echo "$# $bmpath $bmname"
    
    if shownames $go_idx_path |grep $bmname >>/dev/null; then
        echo "$bmname is already occupied"
        return
    fi

    echo "$bmname=$bmpath" >> $go_idx_path
}

golist(){
    cat $go_idx_path | sed -e 's/=/  /'
}



go(){
    if [ $# -eq 1 ]; then
        if shownames $go_idx_path | grep $1 >> /dev/null; then
            matchone=$(grep "$1="  $go_idx_path)
            echo " $matchone" 
            target=${matchone##*=}
            cd $target
        else
            cd $1
        fi
    else
        echo 'usage go KEY'
    fi
}

godel(){
    for key in $@; do
        if shownames $go_idx_path | grep $key >>/dev/null; then
            cat $go_idx_path | grep "$key="
            echo "is deleted"
            sed -i -e "/^${key}=/d" $go_idx_path
        fi
    done
}

aliasdel(){
    for key in $@;
    do
        if shownames $alias_idx_path |grep $key >>/dev/null;
        then
            cat $alias_idx_path |grep "$key="
            echo "is deleted"
            sed -i -e "/^alias ${key}=/d" $alias_idx_path
            unalias $key
        fi
    done
}


################################
########## fast go end #########
################################

