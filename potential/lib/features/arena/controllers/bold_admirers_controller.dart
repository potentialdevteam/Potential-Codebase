import 'package:potential/features/arena/cubit/bold_admirers_cubit.dart';
import 'package:potential/features/home/models/user_model.dart';

class BoldAdmirersController {
  static List<BoldAdmirerState> getBoldAdmirerUsers() {
    return List.generate(4, (index) {
      return BoldAdmirerState(
        userModel: UserModel(
          email: "priya@gmail.com",
          name: "Priya Shah",
          age: 25,
          gender: "Female",
          location: "New Delhi",
          education: "Student",
          workExperience: "Internship",
          socialMediaHandle: "@priya_sharma",
          mysteryMode: false,
          profilePictures: [
            "https://images.pexels.com/photos/1081685/pexels-photo-1081685.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          ],
          questionAnswers: {
            "Spark": {
              "Which fictional charachter do I relate to most?":
                  "Luna Lovegood -quirky, kind, and finds magic everywhere.",
              "The worst joke I have heard is...":
                  "Why are horses in good shape? Because they are on a stable diet.",
              "Pet Preference - Dogs or Cats": "Puppies, I cannot stand cats.",
            },

            "Mind": {
              "My biggest flaw is...": "Overly critical of myself.",
              "Traditional gender roles in a relationship?":
                  "As long as one cooks and the other cleans, I am fine with it.",
              "How future-oriented am i...":
                  "I try to live in the moment, but i end up thinking about legacy, fortune, etc. and the DEEPER STUFF at times.",
            },
            "Heart": {
              "What does love mean to me?":
                  "A deep connection that grows over time.",
              "What's one thing I am really prowd of?":
                  "I won a national level squash championship 2 years ago for which i slogged my ass off, but that's another topic to discuss",
              "How important is a person's past for building a future?":
                  "Very important; it shapes who they are today.",
            },
            "Soul": {
              "Do you believe in soulmates ? If so, what does that mean to you?":
                  "Yes but more like \"Built not born\". Someone who chooses to grow with you, not just for you.",
              "What does the purpose of life look like for you?":
                  "Leaving things better than I found them: people, places, chessboards.",
              "What am I hoping to find or achieve throught \"Potential\"?":
                  "A person to walk through the journey of life with I suppose...",
            },
          },
          soulUnlocked: true,
        ),

        categoryLiked: index == 0
            ? "Soul"
            : index == 1
            ? "Spark"
            : index == 2
            ? "Mind"
            : "Heart",
        assetPath: index == 0
            ? "assets/svg/soul_card.svg"
            : index == 1
            ? "assets/svg/spark_card.svg"
            : index == 2
            ? "assets/svg/mind_card.svg"
            : "assets/svg/heart_card.svg",
        question: index == 0 ? "Do you believe in soulmates?" : null,
        answer: index == 0
            ? "Yes but more like \"Built not born\". Someone who chooses to grow with you, not just for you."
            : null,
        appreciation: index == 0 ? "Ohh Great, me too!" : null,
      );
    });
  }
}
