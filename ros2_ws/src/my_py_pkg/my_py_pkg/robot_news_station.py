#!/usr/bin/env python3
import rclpy
from rclpy.node import Node
    
    
class RobotNewsStationNode(Node): # MODIFY NAME
    def __init__(self):
        super().__init__("robot_news_station") # MODIFY NAME
        self.publishers_ = self.create_publisher()
    
def main(args=None):
    rclpy.init(args=args)
    node = RobotoNewStationNode() # MODIFY NAME
    rclpy.spin(node)
    rclpy.shutdown()
    
    
if __name__ == "__main__":
    main()
