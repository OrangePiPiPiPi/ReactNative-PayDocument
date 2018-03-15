# ReactNative-PayDocument
注：使用的前提是桥接好文件

在reactnative中调用方法
支付宝支付：请求成功后拿到订单（responseJson.data.orderString）
 Pay.onAliPay(responseJson.data.orderString)
                                    .then((message)=>{
                                        console.log("message" + message);
                                        if(message !== "")
                                            this.refs.toast.show(message, DURATION.LENGTH_SHORT);
                                        / / 支付成功的处理
                                   })
                                    .catch(e=>{
                                        console.log("e.message" + e.message);
                                        if(e.message !== "")
                                            this.refs.toast.show(e.message, DURATION.LENGTH_SHORT);
                                        if(e.code == '-1' || e.message =='支付失败') {
                                          / / 支付失败的处理
                                        }
                                    })
                                    
                                    
                                    
  微信支付： 请求拿到订单数据（responseJson.data）
   this.setState({payInfo:Testing.getTestPay(responseJson.data)});
                                let sign = this.getPaySignStrMethod(this.state.payInfo);
                                if(sign==null){
                                    this.refs.toast.show("支付信息请求错误", DURATION.LENGTH_SHORT);
                                    return;
                                }
                                 var params = {
                                        partnerId:this.state.payInfo.partnerId,
                                        prepayId:this.state.payInfo.prepayId,
                                        package:this.state.payInfo.package,
                                        nonceStr:this.state.payInfo.nonceStr,
                                        timeStamp:this.state.payInfo.timeStamp,
                                        sign:sign,
                                    }
                                Pay.onWxPay(params)
                                    .then((message)=>{
                                        console.log("message" + message);
                                        if(message !== "")
                                            this.refs.toast.show(message, DURATION.LENGTH_SHORT);
                                       / / 支付成功的处理
                                    })
                                    .catch(e=>{
                                        console.log("e.message" + e.message);
                                        if(e.message !== "")
                                            this.refs.toast.show(e.message, DURATION.LENGTH_SHORT);
                                        if(e.code == '-1' || e.message =='支付失败') {
                                             / / 支付失败的处理 
                                        }
                                    });
                                    
                                    
