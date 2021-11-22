# CFGifEmotionDemo

## 使用 YYText 实现

### gif表情图文混排demo
优点：使用方便，YYText功能强大，也比较通用，作者很牛  
缺点：
1. 在tabelView中使用情况下，demo验证时，随着往下滑动，内存一直增长，不会释放，最后内存增长到200多M
2. cell滑动过去，再滑动回来时，gif动画静态

总结：使用YYText实现gif图文混排，适合图文相对简单，内容不是很多，且不使用重用机制（cell）的UI组件中使用

![image](https://github.com/yuchuanfeng/CFGifEmotionDemo/blob/YYText/lizi02.gif)
