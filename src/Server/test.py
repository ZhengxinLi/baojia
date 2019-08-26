# coding=utf-8
import sys

import jieba.analyse


def main(content):
    keywords = jieba.analyse.extract_tags(content, topK=20, withWeight=True)
    for item in keywords:
        print(item[0], item[1])


if __name__ == '__main__':
    for i in range(1, len(sys.argv)):
        content = sys.argv[i]
        main(content)
