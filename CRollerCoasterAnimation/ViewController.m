//
//  ViewController.m
//  CRollerCoasterAnimation
//
//  Created by caofei on 2020/10/16.
// https://blog.csdn.net/wang631106979/article/details/51737456

/*
 渐变的背景用CAGradientLayer实现，其他例如山峰，草坪和轨道可以用CAShapeLayer配合UIBezierPath实现，然后云朵，树木和大地直接用CALayer通过设置contents实现，然后云朵和过山车的动画实现用CAKeyframeAnimation，这样分析其实做一个这样的动态效果并不是很难，下面就是实现过程和简单的代码示例
 */


#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CALayer * groundLayer;
@property (nonatomic, strong) CAShapeLayer * yellowPath;
@property (nonatomic, strong) CAShapeLayer * greenPath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGradientLayer:self.view.frame.size];
    [self setupMountainLayer:self.view.frame.size];
    [self setupGrasslandLayer:self.view.frame.size];
    self.groundLayer = [self setupGroundLayer:self.view.frame.size];
    self.yellowPath = [self setupYellowPathLayer:self.view.frame.size];
    [self addCloudAnimation:self.view.frame.size];
    for (NSInteger i =0; i<5; i++) {
        CFTimeInterval timeInterval = CACurrentMediaTime()+0.07*i;
        [self addYellowCarPathAnimation:timeInterval];
    }
}


#pragma mark - init

//初始化背景
-(void)setupGradientLayer:(CGSize)size{
    //渐变色
    CAGradientLayer * layer =[CAGradientLayer layer];
    [layer setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-10)];
    //设置渐变的颜色
    UIColor * color1 = [[UIColor alloc]initWithRed:178.0/255.0 green:226.0/255.0 blue:248.0/255.0 alpha:1];
    UIColor * color2 = [[UIColor alloc]initWithRed:232.0/255.0 green:244.0/255.0 blue:193.0/255.0 alpha:1];
    layer.colors = @[(id)color1.CGColor, (id)color2.CGColor];
    //设置渐变的方向为从左上到右下
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 1);
    [self.view.layer addSublayer:layer];
}

//初始化山峰
-(void)setupMountainLayer:(CGSize)size{
    //第一座山
    CAShapeLayer * mountainOne = [CAShapeLayer layer];
    UIBezierPath * pathOne = [UIBezierPath bezierPath];
    [pathOne moveToPoint:CGPointMake(0, size.height-120)];
    [pathOne addLineToPoint:CGPointMake(100, 100)];
    [pathOne addLineToPoint:CGPointMake(size.width/3, size.height-100)];
    [pathOne addLineToPoint:CGPointMake(size.width/1.5, size.height-50)];
    [pathOne addLineToPoint:CGPointMake(0, size.height)];
    [mountainOne setPath:pathOne.CGPath];
    [mountainOne setFillColor:[UIColor whiteColor].CGColor];
    [self.view.layer addSublayer:mountainOne];
    
    //紫色覆盖
    CAShapeLayer * mountainOneLayer = [CAShapeLayer layer];
    UIBezierPath * pathLayerOne = [UIBezierPath bezierPath];
    [pathLayerOne moveToPoint:CGPointMake(0, size.height - 120)];
    CGFloat pathOneHeight = [self getPoint:CGPointMake(0, size.height-120) pointTwo:CGPointMake(100, 100) referenceX:55];
    CGFloat pathTwoHeight = [self getPoint:CGPointMake(100, 100) pointTwo:CGPointMake(size.width/3, size.height - 100) referenceX:160];
    
    [pathLayerOne addLineToPoint:CGPointMake(55, pathOneHeight)];
    [pathLayerOne addLineToPoint:CGPointMake(70, pathOneHeight+15)];
    [pathLayerOne addLineToPoint:CGPointMake(90, pathOneHeight)];
    [pathLayerOne addLineToPoint:CGPointMake(110, pathOneHeight+25)];
    [pathLayerOne addLineToPoint:CGPointMake(130, pathOneHeight-5)];
    [pathLayerOne addLineToPoint:CGPointMake(160, pathTwoHeight)];
    
    [pathLayerOne addLineToPoint:CGPointMake(size.width/3, size.height - 100)];
    [pathLayerOne addLineToPoint:CGPointMake(size.width/1.5, size.height - 50)];
    [pathLayerOne addLineToPoint:CGPointMake(0, size.height)];
    [mountainOneLayer setPath:pathLayerOne.CGPath];
    [mountainOneLayer setFillColor:[UIColor colorWithRed:104.0/255.0 green:92.0/255.0 blue:157.0/255.0 alpha:1].CGColor];
    [self.view.layer addSublayer:mountainOneLayer];
    
    
    
    //第二座山
    CAShapeLayer * mountainTwo = [CAShapeLayer layer];
    UIBezierPath * pathTwo = [UIBezierPath bezierPath];
    [pathTwo moveToPoint:CGPointMake(size.width/4, size.height - 90)];
    
    [pathTwo addLineToPoint:CGPointMake(size.width/2.7, 200)];
    [pathTwo addLineToPoint:CGPointMake(size.width/1.8, size.height - 85)];
    [pathTwo addLineToPoint:CGPointMake(size.width/1.6, size.height - 125)];
    [pathTwo addLineToPoint:CGPointMake(size.width/1.35, size.height - 70)];
    [pathTwo addLineToPoint:CGPointMake(0, size.height)];
    
    [mountainTwo setPath:pathTwo.CGPath];
    [mountainTwo setFillColor:[UIColor whiteColor].CGColor];
    
    [self.view.layer insertSublayer:mountainTwo below:mountainOne];
    
    CAShapeLayer * mountainTwoLayer = [CAShapeLayer layer];
    UIBezierPath * pathLayerTwo = [UIBezierPath bezierPath];
    
    [pathLayerTwo moveToPoint:CGPointMake(0, size.height)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width/4, size.height - 90)];

    pathOneHeight = [self getPoint:CGPointMake(size.width/4, size.height - 90) pointTwo:CGPointMake(size.width/2.7, 200) referenceX:size.width/4+50];
    
    pathTwoHeight = [self getPoint:CGPointMake(size.width/1.8, size.height - 85) pointTwo:CGPointMake(size.width/2.7, 200) referenceX:size.width/2.2];
    
    
    CGFloat pathThreeHeight =[self getPoint:CGPointMake(size.width/1.8, size.height - 85) pointTwo:CGPointMake( size.width/1.6, size.height - 125) referenceX:size.width/1.67];
    
    CGFloat pathFourHeight = [self getPoint:CGPointMake(size.width/1.35, size.height - 70) pointTwo:CGPointMake(size.width/1.6, size.height - 125) referenceX:size.width/1.50];
    
    [pathLayerTwo addLineToPoint:CGPointMake(size.width/4+50, pathOneHeight)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width/4+70, pathOneHeight + 15)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width/4+90, pathOneHeight)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width/4+110, pathOneHeight + 15)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width/2.2, pathTwoHeight)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width/1.8, size.height - 85)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width/1.67, pathThreeHeight)];
    [pathLayerTwo addLineToPoint:CGPointMake( size.width/1.65, pathThreeHeight+5)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width/1.60, pathThreeHeight-2)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width/1.58, pathFourHeight+2)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width/1.55,  pathFourHeight-5)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width/1.50,  pathFourHeight)];
    [pathLayerTwo addLineToPoint:CGPointMake(size.width/1.35,  size.height - 70)];
    [pathLayerTwo addLineToPoint:CGPointMake(0, size.height)];
    [mountainTwoLayer setPath:pathLayerTwo.CGPath];
    [mountainTwoLayer setFillColor:[UIColor colorWithRed:75.0/255.0 green:65.0/255.0 blue:111.0/255.0 alpha:1].CGColor];
    [self.view.layer insertSublayer:mountainTwoLayer below:mountainOne];
    
}


//初始化草坪
-(void)setupGrasslandLayer:(CGSize)size{
    CAShapeLayer * grasslandOne = [CAShapeLayer layer];
    //通过UIBezierPath来绘制路径
    
    UIBezierPath * pathOne = [UIBezierPath bezierPath];
    [pathOne moveToPoint:CGPointMake(0, size.height - 20)];
    [pathOne addLineToPoint:CGPointMake(0, size.height - 100)];
    [pathOne addQuadCurveToPoint:CGPointMake(size.width/3.0, size.height - 20) controlPoint:CGPointMake(size.width/6.0, size.height - 100)];
    [grasslandOne setPath:pathOne.CGPath];
    //设置草坪的颜色
    [grasslandOne setFillColor:[UIColor colorWithRed: 82.0/255.0 green:177.0/255.0 blue:44.0/255.0 alpha:1].CGColor];
    [self.view.layer addSublayer:grasslandOne];
    
    CAShapeLayer * grasslandTwo = [CAShapeLayer layer];
    UIBezierPath * pathTwo= [UIBezierPath bezierPath];
    [pathTwo moveToPoint:CGPointMake(0, size.height - 20)];
    
    [pathTwo addQuadCurveToPoint:CGPointMake(size.width, size.height - 60) controlPoint:CGPointMake(size.width/2.0, size.height - 100)];
    [pathTwo addLineToPoint:CGPointMake(size.width, size.height - 20)];
    [grasslandTwo setPath:pathTwo.CGPath];
    [grasslandTwo setFillColor:[UIColor colorWithRed:92.0/255.0 green:195.0/255.0 blue:52.0/255.0 alpha:1].CGColor];
    [self.view.layer addSublayer:grasslandTwo];
}

//初始化大地
-(CALayer*)setupGroundLayer:(CGSize)size{
    CALayer * ground = [CALayer layer];
    [ground setFrame:CGRectMake(0, size.height - 20, size.width, 20)];
    [ground setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ground"]].CGColor];
    [self.view.layer addSublayer:ground];
    return ground;
}



//初始化黄色轨道

-(CAShapeLayer*)setupYellowPathLayer:(CGSize)size{
    
    
    CAShapeLayer * calayer = [CAShapeLayer layer];
    [calayer setBackgroundColor:[UIColor redColor].CGColor];
    //外层线
    [calayer setLineWidth:5];
    [calayer setStrokeColor:[UIColor colorWithRed:210.0/255.0 green:179.0/255.0 blue:54.0/255.0 alpha:1].CGColor];
    
    //架子
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, size.height - 70)];
    [path addCurveToPoint:CGPointMake(size.width/1.5,  200) controlPoint1:CGPointMake(size.width/6, size.height - 200) controlPoint2:CGPointMake( size.width/2.5, size.height+50)];
    [path addQuadCurveToPoint:CGPointMake(size.width+10, size.height/3) controlPoint:CGPointMake(size.width-100,  50)];
    [path addLineToPoint:CGPointMake(size.width + 10, size.height+10)];
    [path addLineToPoint:CGPointMake(0, size.height+10)];
    [calayer setFillColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow"]].CGColor];
    [calayer setPath:path.CGPath];
    [self.view.layer insertSublayer:calayer below:self.groundLayer];
    
    //虚线
    CAShapeLayer * lineLayer = [CAShapeLayer layer];
    [lineLayer setLineCap:kCALineCapRound];
    [lineLayer setStrokeColor:[UIColor whiteColor].CGColor];
    [lineLayer setLineDashPattern:@[[NSNumber numberWithInt:4],[NSNumber numberWithInt:10] ]];
    [lineLayer setLineWidth:2];
    [lineLayer setFillColor:[UIColor clearColor].CGColor];
    [lineLayer setPath:path.CGPath];
    [calayer addSublayer:lineLayer];
    return calayer;
}
////添加树
//-(void)addTreeLayer:(CGSize)size{
//    for (NSInteger i = 0; i<=6; i++) {
//        CALayer * treeOne = [CALayer layer];
//        [treeOne setContents:(__bridge id)[UIImage imageNamed:@"tree"].CGImage];
//        treeOne setFrame:CGRectMake([5,55,70,size.width/3+15,size.width/3+25,size.width-130,size.width-160][index],  size.height - 43, 13,  23)
//    }
//    for index in 0...6 {
   //        let treeOne = CALayer()
   //        treeOne.contents = UIImage.init(named: "tree")?.cgImage
   //        treeOne.frame = CGRect(x: [5,55,70,size.width/3+15,size.width/3+25,size.width-130,size.width-160][index], y: size.height - 43, width: 13, height: 23)
   //        addSublayer(treeOne)
   //    }
   //    for index in 0...3 {
   //        let treeOne = CALayer()
   //        treeOne.contents = UIImage.init(named: "tree")?.cgImage
   //        treeOne.frame = CGRect(x: [10,60,size.width/3,size.width-150][index], y: size.height - 52, width: 18, height: 32)
   //        addSublayer(treeOne)
   //    }
   //    for index in 0...1 {
   //        let treeOne = CALayer()
   //        treeOne.contents = UIImage.init(named: "tree")?.cgImage
   //        treeOne.frame = CGRect(x: [size.width-210,size.width-50][index], y: [size.height - 75,size.height - 80][index], width: 18, height: 32)
   //        insertSublayer(treeOne, below: yellowPath)
   //    }
   //    for index in 0...2 {
   //        let treeOne = CALayer()
   //        treeOne.contents = UIImage.init(named: "tree")?.cgImage
   //        treeOne.frame = CGRect(x: [size.width-235, size.width-220, size.width-40][index], y: [size.height - 67 ,size.height - 67 , size.height - 72][index], width: 13, height: 23)
   //        insertSublayer(treeOne, below: yellowPath)
   //    }
//}




////初始化云朵动画
-(void)addCloudAnimation:(CGSize)size{
    CALayer * cloudLayer = [CALayer layer];
    [cloudLayer setContents:(__bridge id)[UIImage imageNamed:@"cloud"].CGImage];
    [cloudLayer setFrame:CGRectMake(0, 0, 63, 20)];
    [self.view.layer addSublayer:cloudLayer];
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(size.width + 63, 40)];
    [path addLineToPoint:CGPointMake(-63, 40)];
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation setPath:path.CGPath];
    [animation setDuration:10];
    [animation setAutoreverses:NO];
    [animation setRepeatCount:MAXFLOAT];
    [animation setCalculationMode:kCAAnimationPaced];
    [cloudLayer addAnimation:animation forKey:@"position"];
  
}


//添加黄色轨道的动画
-(void)addYellowCarPathAnimation:(CFTimeInterval)beginTime{
    CALayer * carLayer = [CALayer layer];
    [carLayer setFrame:CGRectMake(0, 0, 17, 11)];
    
    
    //????carLayer.setAffineTransform(carLayer.affineTransform().translatedBy(x: 0, y: -7))
    [carLayer setAffineTransform:CGAffineTransformTranslate(carLayer.affineTransform, 0, -7)];
    [carLayer setContents:(__bridge id)[UIImage imageNamed:@"care"].CGImage];
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation setPath:self.yellowPath.path];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setDuration:6];
    [animation setBeginTime:beginTime];
    [animation setRepeatCount:MAXFLOAT];
    [animation setAutoreverses:NO];
    [animation setCalculationMode:kCAAnimationCubicPaced];
    [animation setRotationMode:kCAAnimationRotateAuto];
    [self.yellowPath addSublayer:carLayer];
    [carLayer addAnimation:animation forKey:@"carAnimation"];
}


//初始化绿色轨道
//func initGreenPathLayer(_ size:CGSize) -> CAShapeLayer {
//    let calayer:CAShapeLayer = CAShapeLayer()
//    calayer.backgroundColor = UIColor.red.cgColor
//    calayer.lineWidth = 5
//    calayer.fillRule = CAShapeLayerFillRule.evenOdd
//    calayer.strokeColor = UIColor.init(red: 0.0/255.0, green: 147.0/255.0, blue: 163.0/255.0, alpha: 1.0).cgColor
//    let path:UIBezierPath = UIBezierPath()
//    path.lineCapStyle = .round
//    path.lineJoinStyle = .round
//    path.move(to: CGPoint(x: size.width + 10, y: size.height))
//    path.addLine(to: CGPoint(x: size.width + 10, y: size.height - 70))
//    path.addQuadCurve(to: CGPoint(x: size.width/1.8, y: size.height - 70), controlPoint: CGPoint(x: size.width - 120, y: 200))
//    path.addArc(withCenter: CGPoint(x: size.width/1.9, y: size.height - 140), radius: 70, startAngle: CGFloat(0.5*M_PI), endAngle: CGFloat(2.5*M_PI), clockwise: true)
//    path.addCurve(to: CGPoint(x: 0, y: size.height - 100), controlPoint1: CGPoint(x: size.width/1.8 - 60, y: size.height - 60), controlPoint2: CGPoint(x: 150, y: size.height/2.3))
//    path.addLine(to: CGPoint(x: -100, y: size.height + 10))
//    calayer.fillColor = UIColor.clear.cgColor
//    calayer.path = path.cgPath
//    insertSublayer(calayer, below: groundLayer)
//
//    let greenLayer:CAShapeLayer = CAShapeLayer()
//    greenLayer.fillRule = CAShapeLayerFillRule.evenOdd
//    greenLayer.strokeColor = UIColor.init(red: 0.0/255.0, green: 147.0/255.0, blue: 163.0/255.0, alpha: 1.0).cgColor
//    let grennPath:UIBezierPath = UIBezierPath()
//    grennPath.move(to: CGPoint(x: size.width + 10, y: size.height))
//    grennPath.addLine(to: CGPoint(x: size.width + 10, y: size.height - 70))
//    grennPath.addQuadCurve(to: CGPoint(x: size.width/1.8, y: size.height - 70), controlPoint: CGPoint(x: size.width - 120, y: 200))
//    grennPath.addCurve(to: CGPoint(x: 0, y: size.height - 100), controlPoint1: CGPoint(x: size.width/1.8 - 60, y: size.height - 60), controlPoint2: CGPoint(x: 150, y: size.height/2.3))
//    grennPath.addLine(to: CGPoint(x: -100, y: size.height + 10))
//    greenLayer.fillColor = UIColor.init(patternImage: UIImage.init(named: "green")!).cgColor
//    greenLayer.path = grennPath.cgPath
//    insertSublayer(greenLayer, below: calayer)
//
//    let lineLayer:CAShapeLayer = CAShapeLayer()
//    lineLayer.lineCap = CAShapeLayerLineCap.round
//    lineLayer.strokeColor = UIColor.white.cgColor
//    lineLayer.lineDashPattern = [NSNumber.init(value: 1 as Int32),NSNumber.init(value: 5 as Int32)]
//    lineLayer.lineWidth = 2
//    lineLayer.fillColor = UIColor.clear.cgColor
//    lineLayer.path = path.cgPath
//    calayer.addSublayer(lineLayer)
//
//    return calayer
//}
//
////添加绿色轨道的动画
//func addGreenCarPathAnimation(_ size:CGSize, beginTime: CFTimeInterval) {
//    let carLayer:CALayer = CALayer()
//    carLayer.frame = CGRect(x: 0, y: 0, width: 17, height: 11)
//    carLayer.contents = UIImage.init(named: "otherCar")!.cgImage
//
//    //绘制路径
//    let path:UIBezierPath = UIBezierPath()
//    path.lineCapStyle = .round
//    path.lineJoinStyle = .round
//    path.move(to: CGPoint(x: size.width + 10, y: size.height - 7))
//    path.addLine(to: CGPoint(x: size.width + 10, y: size.height - 77))
//    path.addQuadCurve(to: CGPoint(x: size.width/1.8, y: size.height - 77), controlPoint: CGPoint(x: size.width - 120, y: 193))
//    path.addArc(withCenter: CGPoint(x: size.width/1.9, y: size.height - 140), radius: 63, startAngle: CGFloat(0.5*M_PI), endAngle: CGFloat(2.5*M_PI), clockwise: true)
//    path.addCurve(to: CGPoint(x: 0, y: size.height - 107), controlPoint1: CGPoint(x: size.width/1.8 - 60, y: size.height - 67), controlPoint2: CGPoint(x: 150, y: size.height/2.3-7))
//    path.addLine(to: CGPoint(x: -100, y: size.height + 7))
//
//    //关键帧动画作用于position
//    let animation:CAKeyframeAnimation = CAKeyframeAnimation.init(keyPath: "position")
//    animation.path = path.cgPath
//    //动画节奏为线性动画
//    animation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.linear)
//    //动画时间
//    animation.duration = 6
//    //动画重复次数
//    animation.repeatCount = MAXFLOAT
//    //动画是否逆转
//    animation.autoreverses = false
//    animation.calculationMode = CAAnimationCalculationMode.cubicPaced
//    animation.beginTime = beginTime
//    //动画角度是否调整
//    animation.rotationMode = CAAnimationRotationMode.rotateAuto
//    addSublayer(carLayer)
//    carLayer.add(animation, forKey: "carAnimation")
//}



#pragma mark - privte
//不知道算出来个什么？山峰锯齿？

-(CGFloat)getPoint:(CGPoint)pointOne pointTwo:(CGPoint)pointTwo referenceX:(CGFloat)referenceX{
    CGFloat x1 = pointOne.x;
    CGFloat y1 = pointOne.y;
    CGFloat x2 = pointTwo.x;
    CGFloat y2 = pointTwo.y;
    CGFloat a;
    CGFloat b;
    a = (y2-y1)/(x2-x1);
    b = y1-a*x1;
    CGFloat y = a*referenceX+b;
    return y;
}

@end
