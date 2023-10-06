import 'dart:math';

import '../utils/premium_user.dart';

class Verse {
  final String verse;
  final String phrase;

  static Verse defaultVerse = Verse(
    verse: "Colossians 2:3",
    phrase: "In whom are hidden all the treasures of wisdom and knowledge.",
  );

  Verse({required this.verse, required this.phrase});
}


class PhraseRepository {

  static Future<Verse> getRandomVerse() async {
    bool isPremium = await isPremiumUser();
    return isPremium ? getPremiumRandomFreeVerse() : getRandomFreeVerse();
  }

  static Verse getRandomFreeVerse() {
    final random = Random();
    final index = random.nextInt(freeVerses.length);
    return freeVerses[index];
  }

  static Verse getPremiumRandomFreeVerse() {
    final random = Random();
    final allVerses = getVerseCategories().values.expand((verses) => verses).toList();
    final index = random.nextInt(allVerses.length);
    return freeVerses[index];
  }

  static Map<String, List<Verse>> getVerseCategories() {
    return {
      'Free verses': freeVerses,
      'Calm': calmVerses,
      'Happy': happyVerses,
      'Wealth': wealthVerses,
      'Love': loveVerses,
      'Motivation': motivationVerses,
      'Wisdom': wisdomVerses,
    };
  }

  static final List<Verse> wisdomVerses = [
    Verse(
      verse: "Proverbs 3:7",
      phrase: "Do not be wise in your own eyes; fear the LORD and shun evil.",
    ),

    Verse(
      verse: "James 1:5",
      phrase: "If any of you lacks wisdom, you should ask God, who gives generously to all without finding fault, and it will be given to you.",
    ),

    Verse(
      verse: "Proverbs 1:7",
      phrase: "The fear of the LORD is the beginning of knowledge, but fools despise wisdom and instruction.",
    ),

    Verse(
      verse: "Proverbs 2:6",
      phrase: "For the LORD gives wisdom; from his mouth come knowledge and understanding.",
    ),

    Verse(
      verse: "Proverbs 4:7",
      phrase: "Wisdom is the principal thing; therefore get wisdom: and with all thy getting get understanding.",
    ),

    Verse(
      verse: "Proverbs 9:10",
      phrase: "The fear of the LORD is the beginning of wisdom, and knowledge of the Holy One is understanding.",
    ),

    Verse(
      verse: "Ecclesiastes 7:12",
      phrase: "For wisdom is a defense as money is a defense, but the excellence of knowledge is that wisdom gives life to those who have it.",
    ),

    Verse(
      verse: "Colossians 2:3",
      phrase: "In whom are hidden all the treasures of wisdom and knowledge.",
    ),

    Verse(
      verse: "Proverbs 13:10",
      phrase: "Where there is strife, there is pride, but wisdom is found in those who take advice.",
    ),

    Verse(
      verse: "Proverbs 16:16",
      phrase: "How much better to get wisdom than gold, to get insight rather than silver!",
    ),

    Verse(
      verse: "Proverbs 19:8",
      phrase: "The one who gets wisdom loves life; the one who cherishes understanding will soon prosper.",
    ),

    Verse(
      verse: "Proverbs 24:14",
      phrase: "Know also that wisdom is like honey for you: If you find it, there is a future hope for you, and your hope will not be cut off.",
    ),

    Verse(
      verse: "Ecclesiastes 10:12",
      phrase: "Words from the mouth of the wise are gracious, but fools are consumed by their own lips.",
    ),

    Verse(
      verse: "1 Corinthians 1:30",
      phrase: "It is because of him that you are in Christ Jesus, who has become for us wisdom from God—that is, our righteousness, holiness and redemption.",
    ),

    Verse(
      verse: "Ephesians 5:15-16",
      phrase: "Be very careful, then, how you live—not as unwise but as wise, making the most of every opportunity, because the days are evil.",
    ),

    Verse(
      verse: "Colossians 4:5-6",
      phrase: "Be wise in the way you act toward outsiders; make the most of every opportunity. Let your conversation be always full of grace, seasoned with salt, so that you may know how to answer everyone.",
    ),

    Verse(
      verse: "James 3:17",
      phrase: "But the wisdom that comes from heaven is first of all pure; then peace-loving, considerate, submissive, full of mercy and good fruit, impartial and sincere.",
    ),
  ];

  static final List<Verse> loveVerses = [
    Verse(
      verse: "1 John 4:8",
      phrase: "Whoever does not love does not know God, because God is love.",
    ),

    Verse(
      verse: "Proverbs 10:12",
      phrase: "Hatred stirs up conflict, but love covers over all wrongs.",
    ),

    Verse(
      verse: "1 Corinthians 13:4-7",
      phrase: "Love is patient, love is kind. It does not envy, it does not boast, it is not proud. It does not dishonor others, it is not self-seeking, it is not easily angered, it keeps no record of wrongs. Love does not delight in evil but rejoices with the truth. It always protects, always trusts, always hopes, always perseveres.",
    ),

    Verse(
      verse: "Romans 13:10",
      phrase: "Love does no harm to a neighbor. Therefore love is the fulfillment of the law.",
    ),

    Verse(
      verse: "1 Peter 4:8",
      phrase: "Above all, love each other deeply, because love covers over a multitude of sins.",
    ),

    Verse(
      verse: "1 John 4:19",
      phrase: "We love because he first loved us.",
    ),

    Verse(
      verse: "John 15:12",
      phrase: "My command is this: Love each other as I have loved you.",
    ),

    Verse(
      verse: "Romans 12:9",
      phrase: "Love must be sincere. Hate what is evil; cling to what is good.",
    ),

    Verse(
      verse: "1 Corinthians 16:14",
      phrase: "Do everything in love.",
    ),

    Verse(
      verse: "Song of Solomon 8:7",
      phrase: "Many waters cannot quench love; rivers cannot sweep it away.",
    ),

    Verse(
      verse: "Ephesians 4:2",
      phrase: "Be completely humble and gentle; be patient, bearing with one another in love.",
    ),

    Verse(
      verse: "Colossians 3:14",
      phrase: "And over all these virtues put on love, which binds them all together in perfect unity.",
    ),

  ];

  static final List<Verse> motivationVerses = [
    Verse(
      verse: "Philippians 4:13",
      phrase: "I can do all things through Christ who strengthens me.",
    ),

    Verse(
      verse: "Joshua 1:9",
      phrase: "Have I not commanded you? Be strong and courageous. Do not be afraid; do not be discouraged, for the LORD your God will be with you wherever you go.",
    ),

    Verse(
      verse: "Proverbs 16:3",
      phrase: "Commit to the LORD whatever you do, and he will establish your plans.",
    ),

    Verse(
      verse: "Galatians 6:9",
      phrase: "Let us not become weary in doing good, for at the proper time we will reap a harvest if we do not give up.",
    ),

    Verse(
      verse: "2 Timothy 1:7",
      phrase: "For God has not given us a spirit of fear, but of power and of love and of a sound mind.",
    ),

    Verse(
      verse: "1 Corinthians 15:58",
      phrase: "Therefore, my dear brothers and sisters, stand firm. Let nothing move you. Always give yourselves fully to the work of the Lord, because you know that your labor in the Lord is not in vain.",
    ),

    Verse(
      verse: "Romans 8:28",
      phrase: "And we know that in all things God works for the good of those who love him, who have been called according to his purpose.",
    ),

    Verse(
      verse: "Proverbs 18:10",
      phrase: "The name of the LORD is a fortified tower; the righteous run to it and are safe.",
    ),

    Verse(
      verse: "Hebrews 12:1",
      phrase: "Therefore, since we are surrounded by such a great cloud of witnesses, let us throw off everything that hinders and the sin that so easily entangles. And let us run with perseverance the race marked out for us.",
    ),

    Verse(
      verse: "Colossians 3:23",
      phrase: "Whatever you do, work at it with all your heart, as working for the Lord, not for human masters.",
    ),

    Verse(
      verse: "Psalm 37:5",
      phrase: "Commit your way to the LORD; trust in him and he will do this.",
    ),

    Verse(
      verse: "Isaiah 40:31",
      phrase: "But those who hope in the LORD will renew their strength. They will soar on wings like eagles; they will run and not grow weary, they will walk and not be faint.",
    ),

  ];

  static final List<Verse> wealthVerses = [
    Verse(
      verse: "Proverbs 10:22",
      phrase: "The blessing of the LORD brings wealth, without painful toil for it.",
    ),

    Verse(
      verse: "Proverbs 13:11",
      phrase: "Dishonest money dwindles away, but whoever gathers money little by little makes it grow.",
    ),

    Verse(
      verse: "Proverbs 22:1",
      phrase: "A good name is more desirable than great riches; to be esteemed is better than silver or gold.",
    ),

    Verse(
      verse: "Ecclesiastes 5:10",
      phrase: "Whoever loves money never has enough; whoever loves wealth is never satisfied with their income.",
    ),

    Verse(
      verse: "Proverbs 23:4",
      phrase: "Do not wear yourself out to get rich; do not trust your own cleverness.",
    ),

    Verse(
      verse: "1 Timothy 6:10",
      phrase: "For the love of money is a root of all kinds of evil. Some people, eager for money, have wandered from the faith and pierced themselves with many griefs.",
    ),

    Verse(
      verse: "Proverbs 28:20",
      phrase: "A faithful person will be richly blessed, but one eager to get rich will not go unpunished.",
    ),

    Verse(
      verse: "Matthew 6:21",
      phrase: "For where your treasure is, there your heart will be also.",
    ),

    Verse(
      verse: "Proverbs 11:28",
      phrase: "Whoever trusts in his riches will fall, but the righteous will thrive like a green leaf.",
    ),

    Verse(
      verse: "Proverbs 15:16",
      phrase: "Better a little with the fear of the LORD than great wealth with turmoil.",
    ),

    Verse(
      verse: "Proverbs 21:20",
      phrase: "The wise store up choice food and olive oil, but fools gulp theirs down.",
    ),

    Verse(
      verse: "Ecclesiastes 7:12",
      phrase: "Wisdom is a shelter as money is a shelter, but the advantage of knowledge is this: Wisdom preserves those who have it.",
    ),

    Verse(
      verse: "Luke 12:15",
      phrase: "Then he said to them, Watch out! Be on your guard against all kinds of greed; life does not consist in an abundance of possessions.",
    ),

    Verse(
      verse: "1 Timothy 6:17",
      phrase: "Command those who are rich in this present world not to be arrogant nor to put their hope in wealth, which is so uncertain, but to put their hope in God, who richly provides us with everything for our enjoyment.",
    ),

    Verse(
      verse: "Proverbs 3:9-10",
      phrase: "Honor the LORD with your wealth, with the firstfruits of all your crops; then your barns will be filled to overflowing, and your vats will brim over with new wine.",
    ),

    Verse(
      verse: "Proverbs 8:18",
      phrase: "With me are riches and honor, enduring wealth and prosperity.",
    ),

    Verse(
      verse: "Proverbs 10:4",
      phrase: "Lazy hands make for poverty, but diligent hands bring wealth.",
    ),

    Verse(
      verse: "Proverbs 14:24",
      phrase: "The wealth of the wise is their crown, but the folly of fools yields folly.",
    ),

    Verse(
      verse: "Proverbs 18:11",
      phrase: "The wealth of the rich is their fortified city; they imagine it a wall too high to scale.",
    ),

    Verse(
      verse: "Proverbs 24:4",
      phrase: "Through knowledge its rooms are filled with rare and beautiful treasures.",
    ),

    Verse(
      verse: "Ecclesiastes 2:26",
      phrase: "To the person who pleases him, God gives wisdom, knowledge and happiness, but to the sinner he gives the task of gathering and storing up wealth to hand it over to the one who pleases God.",
    ),

  ];

  static final List<Verse> happyVerses = [
    Verse(
      verse: "Philippians 4:7",
      phrase: "And the peace of God, which transcends all understanding, will guard your hearts and your minds in Christ Jesus.",
    ),

    Verse(
      verse: "John 14:27",
      phrase: "Peace I leave with you; my peace I give you. I do not give to you as the world gives. Do not let your hearts be troubled and do not be afraid.",
    ),

    Verse(
      verse: "Proverbs 17:22",
      phrase: "A cheerful heart is good medicine, but a crushed spirit dries up the bones.",
    ),

    Verse(
      verse: "Psalm 16:11",
      phrase: "You make known to me the path of life; in your presence there is fullness of joy; at your right hand are pleasures forevermore.",
    ),

    Verse(
      verse: "Psalm 4:7",
      phrase: "You have put more joy in my heart than they have when their grain and wine abound.",
    ),

    Verse(
      verse: "Romans 15:13",
      phrase: "May the God of hope fill you with all joy and peace in believing, so that by the power of the Holy Spirit you may abound in hope.",
    ),

    Verse(
      verse: "Galatians 5:22",
      phrase: "But the fruit of the Spirit is love, joy, peace, patience, kindness, goodness, faithfulness.",
    ),

    Verse(
      verse: "Psalm 119:165",
      phrase: "Great peace have those who love your law, and nothing can make them stumble.",
    ),

    Verse(
      verse: "Isaiah 26:3",
      phrase: "You will keep in perfect peace those whose minds are steadfast, because they trust in you.",
    ),

    Verse(
      verse: "Psalm 29:11",
      phrase: "The LORD gives strength to his people; the LORD blesses his people with peace.",
    ),

    Verse(
      verse: "Psalm 37:11",
      phrase: "But the meek will inherit the land and enjoy peace and prosperity.",
    ),

    Verse(
      verse: "Matthew 5:9",
      phrase: "Blessed are the peacemakers, for they will be called children of God.",
    ),

    Verse(
      verse: "Psalm 85:8",
      phrase: "I will listen to what God the LORD says; he promises peace to his people, his faithful servants.",
    ),

    Verse(
      verse: "Romans 14:17",
      phrase: "For the kingdom of God is not a matter of eating and drinking, but of righteousness, peace and joy in the Holy Spirit.",
    ),

    Verse(
      verse: "Psalm 30:5",
      phrase: "For his anger lasts only a moment, but his favor lasts a lifetime; weeping may stay for the night, but rejoicing comes in the morning.",
    ),

    Verse(
      verse: "Psalm 34:14",
      phrase: "Turn from evil and do good; seek peace and pursue it.",
    ),

    Verse(
      verse: "Psalm 94:19",
      phrase: "When anxiety was great within me, your consolation brought me joy.",
    ),

    Verse(
      verse: "Proverbs 12:20",
      phrase: "Deceit is in the hearts of those who plot evil, but those who promote peace have joy.",
    ),

    Verse(
      verse: "Isaiah 12:2",
      phrase: "Surely God is my salvation; I will trust and not be afraid. The LORD, the LORD himself, is my strength and my defense; he has become my salvation.",
    ),

    Verse(
      verse: "Isaiah 32:17",
      phrase: "The fruit of that righteousness will be peace; its effect will be quietness and confidence forever.",
    ),

    Verse(
      verse: "Isaiah 55:12",
      phrase: "You will go out in joy and be led forth in peace; the mountains and hills will burst into song before you, and all the trees of the field will clap their hands.",
    ),

    Verse(
      verse: "John 16:33",
      phrase: "I have told you these things, so that in me you may have peace. In this world you will have trouble. But take heart! I have overcome the world.",
    ),

    Verse(
      verse: "Romans 5:1",
      phrase: "Therefore, since we have been justified through faith, we have peace with God through our Lord Jesus Christ.",
    ),

    Verse(
      verse: "Romans 8:6",
      phrase: "The mind governed by the flesh is death, but the mind governed by the Spirit is life and peace.",
    ),

    Verse(
      verse: "Romans 12:18",
      phrase: "If it is possible, as far as it depends on you, live at peace with everyone.",
    ),

    Verse(
      verse: "Romans 15:33",
      phrase: "The God of peace be with you all. Amen.",
    ),

    Verse(
      verse: "Galatians 5:22-23",
      phrase: "But the fruit of the Spirit is love, joy, peace, forbearance, kindness, goodness, faithfulness, gentleness and self-control.",
    ),

    Verse(
      verse: "Colossians 3:15",
      phrase: "Let the peace of Christ rule in your hearts, since as members of one body you were called to peace. And be thankful.",
    ),

    Verse(
      verse: "1 Thessalonians 5:16-18",
      phrase: "Rejoice always, pray continually, give thanks in all circumstances; for this is God’s will for you in Christ Jesus.",
    ),

    Verse(
      verse: "Hebrews 12:14",
      phrase: "Make every effort to live in peace with everyone and to be holy; without holiness no one will see the Lord.",
    ),
  ];

  static final List<Verse> calmVerses = [

    Verse(
      verse: "Philippians 4:7",
      phrase: "And the peace of God, which transcends all understanding, will guard your hearts and your minds in Christ Jesus.",
    ),
    Verse(
      verse: "John 14:27",
      phrase: "Peace I leave with you; my peace I give you. I do not give to you as the world gives. Do not let your hearts be troubled and do not be afraid.",
    ),
    Verse(
      verse: "Isaiah 26:3",
      phrase: "You will keep in perfect peace those whose minds are steadfast, because they trust in you.",
    ),
    Verse(
      verse: "Psalm 4:8",
      phrase: "In peace I will lie down and sleep, for you alone, LORD, make me dwell in safety.",
    ),
    Verse(
      verse: "Romans 15:13",
      phrase: "May the God of hope fill you with all joy and peace as you trust in him.",
    ),
    Verse(
      verse: "Psalm 29:11",
      phrase: "The LORD gives strength to his people; the LORD blesses his people with peace.",
    ),
    Verse(
      verse: "Matthew 11:28-29",
      phrase: "Come to me, all you who are weary and burdened, and I will give you rest. Take my yoke upon you and learn from me, for I am gentle and humble in heart, and you will find rest for your souls.",
    ),
    Verse(
      verse: "Psalm 37:11",
      phrase: "But the meek will inherit the land and enjoy peace and prosperity.",
    ),
    Verse(
      verse: "Romans 5:1",
      phrase: "Therefore, since we have been justified through faith, we have peace with God through our Lord Jesus Christ.",
    ),
    Verse(
      verse: "Psalm 119:165",
      phrase: "Great peace have those who love your law, and nothing can make them stumble.",
    ),
    Verse(
      verse: "Colossians 3:15",
      phrase: "Let the peace of Christ rule in your hearts, since as members of one body you were called to peace.",
    ),
    Verse(
      verse: "2 Thessalonians 3:16",
      phrase: "Now may the Lord of peace himself give you peace at all times and in every way.",
    ),
    Verse(
      verse: "Isaiah 32:17",
      phrase: "The fruit of that righteousness will be peace; its effect will be quietness and confidence forever.",
    ),
    Verse(
      verse: "Psalm 85:8",
      phrase: "I will listen to what God the LORD says; he promises peace to his people, his faithful servants.",
    ),
    Verse(
      verse: "Proverbs 12:20",
      phrase: "Deceit is in the hearts of those who plot evil, but those who promote peace have joy.",
    ),
    Verse(
      verse: "Isaiah 54:10",
      phrase: "Though the mountains be shaken and the hills be removed, yet my unfailing love for you will not be shaken nor my covenant of peace be removed.",
    ),
    Verse(
      verse: "James 3:18",
      phrase: "Peacemakers who sow in peace reap a harvest of righteousness.",
    ),
    Verse(
      verse: "Isaiah 12:2",
      phrase: "Surely God is my salvation; I will trust and not be afraid.",
    ),
    Verse(
      verse: "Psalm 23:4",
      phrase: "Even though I walk through the darkest valley, I will fear no evil, for you are with me.",
    ),
    Verse(
      verse: "Psalm 34:14",
      phrase: "Turn from evil and do good; seek peace and pursue it.",
    ),
    Verse(
      verse: "1 Peter 5:7",
      phrase: "Cast all your anxiety on him because he cares for you.",
    ),
    Verse(
      verse: "2 Timothy 1:7",
      phrase: "For God has not given us a spirit of fear, but of power and of love and of a sound mind.",
    ),
    Verse(
      verse: "Psalm 55:22",
      phrase: "Cast your cares on the LORD and he will sustain you.",
    ),
    Verse(
      verse: "1 Corinthians 14:33",
      phrase: "For God is not a God of disorder but of peace.",
    ),
    Verse(
      verse: "Galatians 5:22",
      phrase: "But the fruit of the Spirit is love, joy, peace, patience, kindness, goodness, faithfulness.",
    ),
    Verse(
      verse: "Romans 8:6",
      phrase: "The mind governed by the flesh is death, but the mind governed by the Spirit is life and peace.",
    ),
    Verse(
      verse: "Psalm 46:10",
      phrase: "Be still, and know that I am God.",
    ),
    Verse(
      verse: "Romans 12:18",
      phrase: "If it is possible, as far as it depends on you, live at peace with everyone.",
    ),
    Verse(
      verse: "Hebrews 12:14",
      phrase: "Make every effort to live in peace with everyone and to be holy.",
    ),
    Verse(
      verse: "Psalm 120:7",
      phrase: "I am for peace; but when I speak, they are for war.",
    ),
    Verse(
      verse: "Proverbs 15:18",
      phrase: "Hot tempers cause arguments, but patience brings peace.",
    ),
    Verse(
      verse: "Philippians 4:13",
      phrase: "I can do all this through him who gives me strength.",
    ),
  ];


  static final List<Verse> freeVerses
  = [

    Verse(
      verse: "Proverbs 15:18",
      phrase: "Hot tempers cause arguments, but patience brings peace.",
    ),
    Verse(
      verse: "Philippians 4:13",
      phrase: "I can do all this through him who gives me strength.",
    ),
    Verse(
      verse: "Matthew 6:33",
      phrase: "But seek first his kingdom and his righteousness, and all these things will be given to you as well.",
    ),

    Verse(
      verse: "Luke 6:31",
      phrase: "Do to others as you would have them do to you.",
    ),
    Verse(
      verse: "Proverbs 10:22",
      phrase: "The blessing of the Lord brings wealth, without painful toil for it.",
    ),
    Verse(
      verse: "Proverbs 13:11",
      phrase: "Dishonest money dwindles away, but whoever gathers money little by little makes it grow.",
    ),
    Verse(
      verse: "Psalm 34:8",
      phrase: "Taste and see that the Lord is good. blessed is the one who takes refuge in him.",
    ),
    Verse(
      verse: "1 Peter 5:7",
      phrase: "Cast all your anxiety on him because he cares for you.",
    ),
    Verse(
      verse: "1 Corinthians 16:14 ",
      phrase: "Let all that you do be done in love.",
    ),
    Verse(
      verse: "Hebrews 13:8",
      phrase: "Jesus Christ is the same yesterday, today and forever.",
    ),
  ];
}
