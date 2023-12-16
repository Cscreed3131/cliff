import 'package:flutter/material.dart';

class QuestionsWidget extends StatelessWidget {
  const QuestionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "1. Two Sum",
          style: TextStyle(
            fontFamily: 'IBMPlexMono',
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.\nYou may assume that each input would have exactly one solution, and you may not use the same element twice.\nYou can return the answer in any order.",
          style: TextStyle(
            fontFamily: 'IBMPlexMono',
            fontSize: 15,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Example 1:\nInput: nums = [2,7,11,15], target = 9\nOutput: [0,1]\nOutput: Because nums[0] + nums[1] == 9, we return [0, 1].",
          style: TextStyle(
            fontFamily: 'IBMPlexMono',
            fontSize: 15,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Example 2:\nInput: nums = [3,2,4], target = 6\nOutput: [1,2]",
          style: TextStyle(
            fontFamily: 'IBMPlexMono',
            fontSize: 15,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Example 3:\nInput: nums = [3,3], target = 6\nOutput: [0,1]",
          style: TextStyle(
            fontFamily: 'IBMPlexMono',
            fontSize: 15,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Constraints:\n2 <= nums.length <= 104\n-109 <= nums[i] <= 109\n-109 <= target <= 109\nOnly one valid answer exists.",
          style: TextStyle(
            fontFamily: 'IBMPlexMono',
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
