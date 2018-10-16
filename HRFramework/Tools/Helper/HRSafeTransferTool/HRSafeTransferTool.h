
/*=======================================
||    @param name   SafeTransferTool    ||
||    @param author muyingbo            ||
||    @param date   2016-03-28          ||
========================================*/

#ifndef LMSafeTransferTool_h
#define LMSafeTransferTool_h


#define LM_INLINE static inline
/*!
 * 从将字符串转换为安全字符串 如果传入字符串为null则返回“”，若果传入字符串为NSNumber类型 则返回对应的NSString
 * @param string 原字符串
 */
LM_INLINE NSString *NotNilStringFromString(id string){
    id temp = string;
    if ([temp isKindOfClass:[NSString class]]){
        return temp;
    }else if([temp isKindOfClass:[NSNumber class]]){
        return [temp stringValue];
    }
    return @"";
}

/*!
 * 从字典中解析出字符串 如果不存在对应字符串则返回“”，如果字符串类型为NSNumber 则转换为NSString
 * @param dic 字典
 * @param key 键值
 */
LM_INLINE NSString *EncodeStringFromDicWithDefaultValue(id dic, NSString *key,NSString *defaultValue){
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return NotNilStringFromString(defaultValue);
    }
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSString class]]){
        return temp;
    }
    else if ([temp isKindOfClass:[NSNumber class]]){
        return [temp stringValue];
    }
    return NotNilStringFromString(defaultValue);
}

/*!
 * 从字典中解析出字符串 如果不存在对应字符串则返回“”，如果字符串类型为NSNumber 则转换为NSString
 * @param dic 字典
 * @param key 键值
 */
LM_INLINE NSString *EncodeStringFromDic(id dic, NSString *key){
    return EncodeStringFromDicWithDefaultValue(dic, key, @"");
}

/*!
 * 从字典中解析出NSNumer 如果不存在对应NSNumber则返回@(-1)，如果字符串类型为NSStirng 则转换为NSNumber
 * @param dic 字典
 * @param key 键值
 */
LM_INLINE NSNumber *EncodeIntegerFromDic(id dic, NSString *key){
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return @(-1);
    }
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSString class]]){
        return [NSNumber numberWithInt:[temp intValue]];
    }
    else if ([temp isKindOfClass:[NSNumber class]]){
        return temp;
    }
    return @(-1);
}

/*!
 * 从字典中解析出字典 如果不存在对应的字典则返回@{}
 * @param dic 字典
 * @param key 键值
 */
LM_INLINE NSDictionary *EncodeDicFromDic(id dic, NSString *key){
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return @{};
    }
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSDictionary class]]){
        return temp;
    }
    return @{};
}

/*!
 * 从字典中解析出数组 如果不存在对应的数组则返回@[]
 * @param dic 字典
 * @param key 键值
 */
LM_INLINE NSArray *EncodeArrayFromDic(id dic, NSString *key){
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return @[];
    }
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSArray class]]){
        return temp;
    }
    return @[];
}



#endif /* LMSafeTransferTool_h */
