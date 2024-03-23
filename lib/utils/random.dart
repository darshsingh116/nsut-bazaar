import 'dart:math';

class RandomUtil{
  static String generateRandomImage() {
    // Generate a random number from 1 to 9
    int randomNumber = Random().nextInt(3) + 1;
    return '$randomNumber.jpeg';
  }
}