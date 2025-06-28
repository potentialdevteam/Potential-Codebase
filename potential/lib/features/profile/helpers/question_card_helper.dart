import 'package:flutter/material.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/profile/cubit/user_questions_cubit.dart';
import 'package:potential/features/profile/models/card_info_popup.dart';
import 'package:potential/features/profile/models/question_categories.dart';
import 'package:potential/features/profile/views/card_question_page.dart';
import 'package:potential/shared/models/basic_card.dart';

class CardsHelperClass {
  static void getNavigationByCardTitle(
    String title,
    BuildContext context,
    BasicCardModel card,
  ) {
    switch (title) {
      case "Spark":
        Navigator.push(
          context,
          FadeRouteTransition(
            dest: CardQuestionPage(
              title: title,
              yourPotentialTitle: "Some Tips to Ignite Your Spark",
              titleColor: AppColors.sparkPurple,
              questions: getSparkQuestions(context),
              yourPotential: sparkPotentials,
              titleEndColor: card.cardGradientColors[1],
              titleStartColor: card.cardGradientColors[0],
            ),
          ),
        );
        break;
      case "Mind":
        Navigator.push(
          context,
          FadeRouteTransition(
            dest: CardQuestionPage(
              title: title,
              yourPotentialTitle: "Some Reminders to Sharpen Your Mind",
              titleColor: AppColors.mindBlue,
              questions: getMindQuestions(context),
              yourPotential: mindPotentials,
              titleEndColor: card.cardGradientColors[1],
              titleStartColor: card.cardGradientColors[0],
            ),
          ),
        );
        break;
      case "Heart":
        Navigator.push(
          context,
          FadeRouteTransition(
            dest: CardQuestionPage(
              title: title,
              yourPotentialTitle: "Some Practices to Open Your Heart",
              titleColor: AppColors.heartOrange,
              questions: getHeartQuestions(context),
              yourPotential: heartPotentials,
              titleEndColor: card.cardGradientColors[1],
              titleStartColor: card.cardGradientColors[0],
            ),
          ),
        );
        break;
      case "Soul":
        Navigator.push(
          context,
          FadeRouteTransition(
            dest: CardQuestionPage(
              title: title,
              yourPotentialTitle: "Some Mantras to Awaken Your Soul",
              titleColor: AppColors.soulYellow,
              questions: getSoulQuestions(context),
              yourPotential: soulPotentials,
              titleEndColor: card.cardGradientColors[1],
              titleStartColor: card.cardGradientColors[0],
            ),
          ),
        );
        break;
      default:
        break;
    }
  }

  static List<BasicCardModel> cardModelS = [
    BasicCardModel(
      cardTitle: "Spark",
      cardDescription: "Vibe.Energy.Chemistry",
      cardAssetPath: "assets/svg/spark_card.svg",
      cardGradientColors: [
        AppColors.sparkPurple,
        const Color.fromARGB(255, 137, 27, 170),
      ],
    ),
    BasicCardModel(
      cardTitle: "Mind",
      cardDescription: "Values.Thoughts.Perspectives",
      cardAssetPath: "assets/svg/mind_card.svg",
      cardGradientColors: [
        const Color.fromARGB(255, 82, 80, 212),
        AppColors.mindBlue,
      ],
    ),
    BasicCardModel(
      cardTitle: "Heart",
      cardDescription: "Empathy.Passion.Emotions",
      cardAssetPath: "assets/svg/heart_card.svg",
      cardGradientColors: [
        AppColors.heartOrange,
        const Color.fromARGB(255, 138, 35, 6),
      ],
    ),
    BasicCardModel(
      cardTitle: "Soul",
      cardDescription: "Self Journey.Destiny.",
      cardAssetPath: "assets/svg/soul_card.svg",
      cardGradientColors: [
        const Color.fromARGB(255, 153, 134, 29),
        AppColors.soulYellow,
      ],
    ),
  ];

  static CardInfoPopupModel getCardPopUpInfoByCategory(
    QuestionCategory category,
    dynamic context,
  ) {
    switch (category) {
      case QuestionCategory.spark:
        return CardInfoPopupModel(
          assetPath: "assets/svg/spark_card.svg",
          infoText: sparkInfoTexts,
          noteTextColor: AppColors.sparkPurple,
          gradientColors: [const Color(0xFFC623F6), const Color(0xFF891BAA)],
        );
      case QuestionCategory.mind:
        return CardInfoPopupModel(
          assetPath: "assets/svg/mind_card.svg",
          infoText: mindInfoTexts,
          noteTextColor: AppColors.mindBlue,
          gradientColors: [const Color(0xFF5250D4), const Color(0xFF0703FF)],
        );
      case QuestionCategory.heart:
        return CardInfoPopupModel(
          assetPath: "assets/svg/heart_card.svg",
          infoText: heartInfoTexts,
          noteTextColor: AppColors.heartOrange,
          gradientColors: [const Color(0xFFFF5325), const Color(0xFF8A2306)],
        );
      case QuestionCategory.soul:
        return CardInfoPopupModel(
          assetPath: "assets/svg/soul_card.svg",
          infoText: soulInfoTexts,
          noteTextColor: AppColors.soulYellow,
          gradientColors: [const Color(0xFF99861D), const Color(0xFFFFD900)],
        );
    }
  }

  static List<String> getSparkQuestions(BuildContext context) {
    return StaticQuestions.questions[QuestionCategory.spark]!;
  }

  static List<String> getMindQuestions(BuildContext context) {
    return StaticQuestions.questions[QuestionCategory.mind]!;
  }

  static List<String> getHeartQuestions(BuildContext context) {
    return StaticQuestions.questions[QuestionCategory.heart]!;
  }

  static List<String> getSoulQuestions(BuildContext context) {
    return StaticQuestions.questions[QuestionCategory.soul]!;
  }

  // ignore: non_constant_identifier_names
  static List<List<String>> MindMCQQuestions = [
    ["Overly critical of myself", "Perfectionist", "None ;)"],
    [
      "As long as one cooks and the other does the dishes, we're good.",
      "Let's find what works for us",
      "Sometimes gotta be in charge.",
    ],
    [
      "Super, I am far fromt the future.",
      "I live in the moment but I have a vision.",
      "I'm just trying to make it through today.",
    ],
    ["Yes, people can change.", "Second chances should be earned.", "NO."],
    [
      "Freewill shapes our destiny.",
      "It's a mix of both..",
      "Fate brought me here to meet you.",
    ],
    [
      "Yes, I practice my faith.",
      "I'm spiritual but not religious.",
      "Not religious but I pray for a good date.",
    ],
    [
      "Prioritize my mental health.",
      "Pursue my passions fearlessly.",
      "Not downloading another dating app. (well..)",
    ],
    [
      "Kindness over anything.",
      "Success is personal and subjective.",
      "Pinapple belongs on pizza.",
    ],
    [
      "It matters but connection is key.",
      "Not that important; It's about shared values.",
      "Need me a sugar mommy / daddy.",
    ],
    [
      "Yes, they can compliment each other.",
      "Shared values are crucial.",
      "Absolutely; someone has to balance my craziness!",
    ],
  ];

  // ignore: non_constant_identifier_names
  static List<List<String>> HeartMCQQuestions = [
    [
      "A deep connection that grows over time.",
      "Unconditional support through thick and thin.",
      "Complex interplay of brain chemicals.",
    ],
    [
      "Acheiving a significant career milestone.",
      "Making meaningful personal growthand improvements.",
      "Discovering this app.",
    ],
    [
      "Very important; It shapes who they are today.",
      "Somewhat important; we all have a past but can grow.",
      "The past is history, our future is what matters!",
    ],
    [
      "Recently; It was a good emotional release.",
      "I can't remember; I usually keep my emotions in check.",
      "A sad movie usually gets me.",
    ],
    [
      "Finding my purpose.",
      "A meaningful connection with someone special.",
      "I'm just a kid, on an unknown planet in the cosmos.",
    ],
    [
      "Cocktails and conversations over a nice meal.",
      "An adventurous outing that creates fun memories.",
      "Netflix and Chill (no but genuinely)",
    ],
    [
      "Emotional intelligence and good communication skills.",
      "Kindness and empathy towards others.",
      "Must love dogs. (or tolerate my obsession!)",
    ],
    [
      "Yes, I want children someday.",
      "Maybe, it depends on the right partner.",
      "No, I prefer to focus on other aspects of life.",
    ],
    [
      "Yes, I believe compromise is essential for harmony.",
      "I'm open to it, but there are certain non-negotiables.",
      "No, and i am pretty honest about it.",
    ],
    [
      "Exploring new places together and enjoying each other's company.",
      "A day filled with snacks, games, and zero responsibilities.",
      "Just lounging around in pajamas while binge-watching our favourite shows.",
    ],
  ];

  static List<String> sparkPotentials = [
    "Be Yourself, Authenticity is More Important than Fitting In.",
    "Be Present in the Moment, Put Away Distractions and Focus on the Person in Front of You.",
    "Greet the First Person You See with a Smile, It Instantly Creates a Connection.",
    "Arrive a Few Minutes Early at Important Events to Center Yourself, Punctuality is a Very Attractive Trait.",
    "Compliment Someone on Something They Have Put Effort Into, It Shows U Notice the Little Things.",
    "Learn to Match Their Energy, If They're Calm, Slow Your Speech; If Lively, Amp Up Your Enthusiasm.",
    "Wear a Scent that Makes You Feel Confident, It's Your Invisible Signature.",
    "Practice the Art of Observation, Notice the Room Without Being Noticed.",
    "Ask Someone What They're Secretly Proud Of, It's a Question that Digs Deeper than the Surface.",
    "Bring Up a Fun, Lighthearted Debate Topic to Spark Conversation.",
  ];
  static List<String> mindPotentials = [
    "Ask 'Why' Way More Often and Deepen Your Understanding of the World.",
    "Read One Article or Book Chapter on a Topic You Know Nothing About Each Week.",
    "Play Chess Weekly to Hone Strategic Thinking and Use It to Navigate Relationship Challenges.",
    "Rank Your Top 5 Values and Discuss Them with a Partner.",
    "In the Presence of Successful People, Listen More than You Speak.",
    "Collaborate on a Puzzle or Problem, Teamwork Reveals Compatibility.",
    "Learn Like You'll Live Forever, Knowledge Compounds Interest.",
    "Treat Opinions as Evolving Drafts, Not Final Edits.",
    "Debate Ideas, Not People, Intellect Thrives on Respect, Not Ego.",
    "Analyze the Relationship Dynamics Around You to Know What You Would Prefer",
  ];
  static List<String> heartPotentials = [
    "Fall in Love with Your Own Heart's First, It's the Only Way You'll Love Another's Forever.",
    "Express Your Warmth to Your Loved Ones, Send a Voice Note Saying, \"Im Grateful Youre in My Life\"",
    "It Takes Strength to Admit When U Don't Know How to Feel, But Remember That Uncertainty is Part of the Journey.",
    "Practice Forgiving Yourself for Past Mistakes, You Deserve the Same Compassion You Give Others.",
    "Learn to Sit with Discomfort, Not Every Feeling Needs Fixing, But Every Feeling Deserves Respect.",
    "Protect Your Peace by Setting Boundaries, Love Shouldn't Cross Your Mental Health.",
    "Transparency is the Key of Any Relationship, Never Shy Away from It.",
    "Practice Empathy by Imagining Yourself in Their Shoes During a Conversation.",
    "Bridge Emotional Gaps with Nonverbal Cues, a Warm Smile or Attentive Silence Speaks Volumes.",
    "Apologize Freely When You're Wrong, It's Not Weakness, It's Emotional Maturity.",
  ];
  static List<String> soulPotentials = [
    "Sit. Listen. Let Your Soul Speak.",
    "Plant Seeds of Intention Today.",
    "Burn Fears. Grow Wings.",
    "Follow the Pull. Trust the Ache.",
    "Dream Louder than Your Doubts.",
    "Deserve Them. Then Let Destiny Deliver.",
    "Live Boldly, Your Legacy Writes Itself.",
    "One Life. No Rehearsals.",
    "Truth is Your Soul's Mother Tongue.",
    "Roots Dig Deeper After Storms.",
  ];

  static List<String> sparkInfoTexts = [
    "Ah, The Spark!\nThe First Flicker That Turns Into a Beautiful Flame.",
    "Ready to Get Started?",
    "This is Where Your Vibe Begins.",
    "Yes! Those Icebreaker Questions That Will Make the First Conversation Far Less Awkward.",
    "Don't Worry, We've Got You Covered.",
  ];
  static List<String> mindInfoTexts = [
    "Curiosity is Key. What's on Your Mind?",
    "Give Them an Understanding of How You Think and Perceive Things, Your Values and Opinions on Certain Subjects.",
    "Flex That Intellect as Much as U Can!",
    "Your Mind is After All the Compass of All Your Relationships.",
    "Which Direction Do You Want to Head Towards?",
  ];
  static List<String> heartInfoTexts = [
    "Your Heart Has a Story, Lets Make Sure It Gets Told.",
    "In the Hopes of Building a Deeper Bond, Give Them a Glimpse of the Raw Version of You.",
    "Opening Up About How You Feel, Your Emotions and Passions. The Strings of Your Heart Already Know the Kind of Love They're Meant For.",
    "Lets Uncover That Truth Together",
  ];
  static List<String> soulInfoTexts = [
    "You're Hear for Something Real, No Shortcuts This Time, Take Your Time on This Section, There's No Need to Rush It.",
    "Your Soul is Eternal, Make It Is What Makes You, You.",
    "It Has a Purpose That's Meant to be Fulfilled, But That Journey Isn't the Easiest One, Especially Not Alone.",
    "This Isn't About a Date, It's About Destiny.",
    "You're Prepared Now, Enjoy the Ride.",
  ];

  static List<String> cardInfoNotes = [
    "This isnt a profile creation, this is you putting in that extra effort to build meaningfull connections.",
    "Be as authentic and introspective as you possibly can, your potential for a depeer relationship starts by discovering your true self.",
  ];
}
