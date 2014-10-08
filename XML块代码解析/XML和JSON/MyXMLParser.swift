//
//  MyXMLParser.swift
//  XML和JSON
//
//  Created by bingoogol on 14/10/8.
//  Copyright (c) 2014年 bingoogol. All rights reserved.
//

import UIKit

// 必须加上 -> Void 否则下面不能调用
typealias StartElementBlock = (dict:NSDictionary) -> Void
typealias EndElementBlock = (elementName:NSString,result:NSString) -> Void
typealias XmlParserNotificationBlock = () -> Void

class MyXMLParser: NSObject,NSXMLParserDelegate {
    var elementStr:NSMutableString!
    
    // 开始节点名称，例如video，如果检测到此名称，需要实例化对象
    var startElementName:NSString!
    var startElementBlock:StartElementBlock!
    var endElementBlock:EndElementBlock!
    var finishedParser:XmlParserNotificationBlock!
    var errorParser:XmlParserNotificationBlock!
    
    func xmlParserWithData(data:NSData,startElementName:NSString,startElementBlock:StartElementBlock,endElementBlock:EndElementBlock,finishedParser:XmlParserNotificationBlock,errorParser:XmlParserNotificationBlock) {
        self.startElementName = startElementName
        self.startElementBlock = startElementBlock
        self.endElementBlock = endElementBlock
        self.finishedParser = finishedParser
        self.errorParser = errorParser
        var parser = NSXMLParser(data: data)
        parser?.delegate = self
        parser?.parse()
    }
    
    // 在整个解析xml解析完成之前，2、3、4方法会不断被循环调用
    // 1.解析文档（不需要与外部交互）
    func parserDidStartDocument(parser: NSXMLParser) {
        println("开始解析文档")
        if elementStr == nil {
            self.elementStr = NSMutableString()
        }
    }
    // 2.开始解析一个元素（需要与外部交互）
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        println("didStartElement \(elementName)  attributeDict\(attributeDict)")
        if startElementName.isEqualToString(elementName) {
            self.startElementBlock(dict: attributeDict)
        }
        // 开始循环执行第3个方法前，清空中转字符串
        self.elementStr.setString("")
    }
    
    // 3.接收元素的数据（因为元素的内容过大，此方法可能会被重复调用，需要拼接数据）（不需要与外部交互）
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        println("found \(string)")
        self.elementStr.setString(string)
    }
    // 4.结束解析一个元素，根据elementName和第3步的拼接内容，确定对象属性，需要与外部交互
    // namespaceURI: String?, qualifiedName qName: String? 这两处需要自己手动加上？
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        println("didEndElement \(elementName)")
        self.endElementBlock(elementName: elementName,result: NSString(format:self.elementStr))
    }
    
    // 5.解析完档元素，通常需要刷新数据（需要与外界交互）
    func parserDidEndDocument(parser: NSXMLParser) {
        println("解析文档结束")
        self.elementStr.setString("")
        self.finishedParser()
    }
    // 6.解析出错，通知调用方解析出错（需要与外界交互）
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        println("解析出错 \(parseError.localizedDescription)")
        self.errorParser()
    }
}