//
//  FileTreeNode.cpp
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/27/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//


#include "FileTreeNode.hpp"
FileTreeNode::FileTreeNode() {
    this->setData(AWFileInfo());
    printf("to string1: %s\n", toString());
}
FileTreeNode::FileTreeNode(const char *path) {
    this->setData(AWFileInfo());
    struct stat* fileStat = (struct stat *)malloc(sizeof(struct stat));
    if (stat(path, fileStat) != 0) {
        throw notFileOrDirectory;
    }
    if(fileStat->st_mode & S_IFDIR) {
        DIR* dir;
        if ((dir = opendir(path)) == NULL) {
            perror("openddir: ");
        }
        struct dirent* subdir;
        while ((subdir = readdir(dir)) != NULL) {
            if ((subdir->d_type == DT_REG || subdir->d_type == DT_DIR) && subdir->d_name[0] != '.') {
                Node* node = new FileTreeNode(subdir, path);
                this->children->append(node);
                node->parent = this;
            }
        }
        closedir(dir);
    } else {
        throw notDirectory;
    }
    this->setData(AWFileInfo(copy(path), DT_DIR));
}

FileTreeNode::FileTreeNode(dirent *file, const char* directory) {
    this->setData(AWFileInfo());
    //Form a path
    char *fileName = copy(file->d_name);
    if((strcmp(fileName, ".") == 0) || (strcmp(fileName, "..") == 0)) {
        return;
    }
    if (file->d_type == DT_DIR) {
        this->setData(AWFileInfo(fileName, DT_DIR));
        size_t length = strlen(fileName)+strlen(directory)+2;
        char *path = (char *)malloc(length);
        bzero(path, length);
        memcpy(path, directory, strlen(directory));
        path[strlen(directory)] = '/';
        memcpy((path+strlen(directory)+1), fileName, strlen(fileName));
        //Open the directory
        DIR* dir = opendir(path);
        struct dirent* subdir;
        while ((subdir = readdir(dir)) != NULL) {
            if ((subdir->d_type == DT_REG || subdir->d_type == DT_DIR) && subdir->d_name[0] != '.') {
                Node* node = new FileTreeNode(subdir, path);
                this->children->append(node);
                node->parent = this;
            }
        }
        closedir(dir);
    } else {
        this->setData(AWFileInfo(fileName, DT_REG));
    }
}

char * FileTreeNode::toString() {
    if (this->count() <= 0) {
        return copy(this->getData().toString());
    } else {
        char *retval;
        ArrayList<Node *>::Node* node = this->children->rootNode->nextNode;
        retval = copy(node->data->getData().toString());
        while (node->nextNode != NULL) {
            char *buff = ((FileTreeNode *)node->nextNode->data)->toString();
            char *sum = (char *)malloc(strlen(buff)+strlen(retval)+2);
            bzero(sum, strlen(buff)+strlen(retval)+2);
            memcpy(sum, retval, strlen(retval));
            sum[strlen(retval)] = ',';
            memcpy((sum+strlen(retval)+1), buff, strlen(buff));
            free(retval);
            retval = sum;
            node = node->nextNode;
        }
        char *buff = copy(this->getData().toString());
        char *sum = (char *)malloc(strlen(buff)+strlen(retval)+3);
        bzero(sum, strlen(buff)+strlen(retval)+3);
        memcpy(sum, buff, strlen(buff));
        sum[strlen(buff)] = '{';
        memcpy((sum+strlen(buff)+1), retval, strlen(retval));
        sum[strlen(buff)+strlen(retval)+1] = '}';
        free(buff);
        return sum;
    }
}

char * FileTreeNode::toAbsPath() {
    if (this->parent != NULL) {
        char *buff = ((FileTreeNode *)this->parent)->toAbsPath();
        char *retval = (char *)malloc(strlen(buff)+strlen(this->getData().name)+2);
        bzero(retval, strlen(buff)+strlen(this->getData().name)+2);
        memcpy(retval, buff, strlen(buff));
        retval[strlen(buff)] = '/';
        memcpy((retval+strlen(buff)+1), this->getData().name, strlen(this->getData().name));
        return retval;
    } else {
        return this->getData().name;
    }
}

char * FileTreeNode::toPath() {
    if (this->parent != NULL) {
        char *buff = ((FileTreeNode *)this->parent)->toPath();
        char *retval = (char *)malloc(strlen(buff)+strlen(this->getData().name)+2);
        bzero(retval, strlen(buff)+strlen(this->getData().name)+2);
        memcpy(retval, buff, strlen(buff));
        retval[strlen(buff)] = '/';
        memcpy((retval+strlen(buff)+1), this->getData().name, strlen(this->getData().name));
        return retval;
    } else {
        return "root";
    }
}

FileTreeNode* FileTreeNode::deserializedFromString(const char *str) {
    FileTreeNode* retval = new FileTreeNode();
    int index = 0;
    while(str[index] != '{' && str[index] != '\0')
        index++;
    retval->setData(AWFileInfo(copy(str, 0, index)));
    if (str[index++] == '{') {
        int numberOfLayer = 1;
        int nodeInfoBegin = index;
        while(numberOfLayer > 0) {
            switch (str[index++]) {
                case '{':
                    numberOfLayer++;
                    break;
                case '}':
                    numberOfLayer--;
                    break;
                case ',':
                    if(numberOfLayer == 1) {
                        char* nodeStr = copy(str, nodeInfoBegin, index-1-nodeInfoBegin);
                        printf("value %d: %s\n\n", index, nodeStr);
                        retval->appendNode(FileTreeNode::deserializedFromString(nodeStr));
                        free(nodeStr);
                        nodeInfoBegin = index;
                    }
                    break;
                default:
                    break;
            }
        }
    }
    return retval;
}
