import 'dart:math';

class Verse {
  final String verse;
  final String phrase;

  Verse({required this.verse, required this.phrase});
}

class PhraseRepository {
  static final List<Verse> verses = [
    Verse(
      verse: "John 3:16",
      phrase: "For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life.",
    ),
    Verse(
      verse: "Psalm 23:1",
      phrase: "The Lord is my shepherd, I lack nothing.",
    ),
    Verse(
      verse: "Proverbs 3:5-6",
      phrase: "Trust in the Lord with all your heart and lean not on your own understanding; in all your ways submit to him, and he will make your paths straight.",
    ),
    Verse(
      verse: "Romans 8:28",
      phrase: "And we know that in all things God works for the good of those who love him, who have been called according to his purpose.",
    ),
    Verse(
      verse: "Philippians 4:13",
      phrase: "I can do all this through him who gives me strength.",
    ),
    Verse(
      verse: "Jeremiah 29:11",
      phrase: "For I know the plans I have for you,” declares the Lord, “plans to prosper you and not to harm you, plans to give you hope and a future.",
    ),
    Verse(
      verse: "Matthew 6:33",
      phrase: "But seek first his kingdom and his righteousness, and all these things will be given to you as well.",
    ),
    Verse(
      verse: "Isaiah 41:10",
      phrase: "So do not fear, for I am with you; do not be dismayed, for I am your God. I will strengthen you and help you; I will uphold you with my righteous right hand.",
    ),
    Verse(
      verse: "Romans 12:2",
      phrase: "Do not conform to the pattern of this world, but be transformed by the renewing of your mind. Then you will be able to test and approve what God’s will is—his good, pleasing and perfect will.",
    ),
    Verse(
      verse: "1 Corinthians 13:4-7",
      phrase: "Love is patient, love is kind. It does not envy, it does not boast, it is not proud. It does not dishonor others, it is not self-seeking, it is not easily angered, it keeps no record of wrongs. Love does not delight in evil but rejoices with the truth. It always protects, always trusts, always hopes, always perseveres.",
    ),
    Verse(
      verse: "Ephesians 2:8-9",
      phrase: "For it is by grace you have been saved, through faith—and this is not from yourselves, it is the gift of God— not by works, so that no one can boast.",
    ),
    Verse(
      verse: "2 Timothy 3:16",
      phrase: "All Scripture is God-breathed and is useful for teaching, rebuking, correcting and training in righteousness.",
    ),
    Verse(
      verse: "John 14:6",
      phrase: "Jesus answered, 'I am the way and the truth and the life. No one comes to the Father except through me.'",
    ),
    Verse(
      verse: "Romans 10:9",
      phrase: "If you declare with your mouth, 'Jesus is Lord,' and believe in your heart that God raised him from the dead, you will be saved.",
    ),
    Verse(
      verse: "Psalm 19:14",
      phrase: "May these words of my mouth and this meditation of my heart be pleasing in your sight, Lord, my Rock and my Redeemer.",
    ),
    Verse(
      verse: "Psalm 46:10",
      phrase: "He says, 'Be still, and know that I am God; I will be exalted among the nations, I will be exalted in the earth.'",
    ),
    Verse(
      verse: "John 14:27",
      phrase: "Peace I leave with you; my peace I give you. I do not give to you as the world gives. Do not let your hearts be troubled and do not be afraid.",
    ),
    Verse(
      verse: "Isaiah 40:31",
      phrase: "but those who hope in the Lord will renew their strength. They will soar on wings like eagles; they will run and not grow weary, they will walk and not be faint.",
    ),
    Verse(
      verse: "Romans 15:13",
      phrase: "May the God of hope fill you with all joy and peace as you trust in him, so that you may overflow with hope by the power of the Holy Spirit.",
    ),
    Verse(
      verse: "Psalm 34:8",
      phrase: "Taste and see that the Lord is good; blessed is the one who takes refuge in him.",
    ),
    Verse(
      verse: "1 Peter 5:7",
      phrase: "Cast all your anxiety on him because he cares for you.",
    ),
    Verse(
      verse: "Matthew 11:28-30",
      phrase: "Come to me, all you who are weary and burdened, and I will give you rest. Take my yoke upon you and learn from me, for I am gentle and humble in heart, and you will find rest for your souls. For my yoke is easy and my burden is light.",
    ),
    Verse(
      verse: "Psalm 119:105",
      phrase: "Your word is a lamp for my feet, a light on my path.",
    ),
    Verse(
      verse: "John 10:10",
      phrase: "The thief comes only to steal and kill and destroy; I have come that they may have life, and have it to the full.",
    ),
    Verse(
      verse: "Isaiah 53:5",
      phrase: "But he was pierced for our transgressions, he was crushed for our iniquities; the punishment that brought us peace was on him, and by his wounds we are healed.",
    ),
    Verse(
      verse: "Galatians 5:22-23",
      phrase: "But the fruit of the Spirit is love, joy, peace, forbearance, kindness, goodness, faithfulness, gentleness and self-control. Against such things there is no law.",
    ),
    Verse(
      verse: "James 1:5",
      phrase: "If any of you lacks wisdom, you should ask God, who gives generously to all without finding fault, and it will be given to you.",
    ),
    Verse(
      verse: "Psalm 51:10",
      phrase: "Create in me a pure heart, O God, and renew a steadfast spirit within me.",
    ),
    Verse(
      verse: "Hebrews 13:8",
      phrase: "Jesus Christ is the same yesterday, today and forever.",
    ),
  ];

  static Verse getRandomVerse() {
    final random = Random();
    final index = random.nextInt(verses.length);
    return verses[index];
  }
}
