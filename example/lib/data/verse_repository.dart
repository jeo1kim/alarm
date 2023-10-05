import 'dart:math';

class Verse {
  final String verse;
  final String phrase;

  Verse({required this.verse, required this.phrase});
}

class PremiumPhraseRepository {
  static final List<Verse> verses
  = [
    // Spiritual Growth and Virtues
    Verse(
      verse: "Proverbs 3:5",
      phrase: "Trust in the Lord with all your heart and lean not on your own understanding.",
    ),
    Verse(
      verse: "Psalm 46:10",
      phrase: "Be still and know that I am God.",
    ),
    Verse(
      verse: "Philippians 4:13",
      phrase: "I can do all things through Christ who strengthens me.",
    ),
    Verse(
      verse: "1 John 4:8",
      phrase: "God is love.",
    ),
    Verse(
      verse: "2 Timothy 1:7",
      phrase: "For God gave us a spirit not of fear but of power and love and self-control.",
    ),

// Personal Development and Well-being
    Verse(
      verse: "Psalm 23:1",
      phrase: "The Lord is my shepherd, I shall not want.",
    ),
    Verse(
      verse: "Matthew 11:28",
      phrase: "Come to me, all who labor and are heavy laden, and I will give you rest.",
    ),
    Verse(
      verse: "Proverbs 17:22",
      phrase: "A cheerful heart is good medicine.",
    ),

// Relationships and Community
    Verse(
      verse: "Proverbs 27:17",
      phrase: "As iron sharpens iron, so one person sharpens another.",
    ),
    Verse(
      verse: "Ephesians 4:26",
      phrase: "In your anger do not sin.",
    ),
    Verse(
      verse: "1 Peter 4:8",
      phrase: "Above all, love each other deeply, because love covers over a multitude of sins.",
    ),

// Practical Living and Ethics
    Verse(
      verse: "Matthew 6:21",
      phrase: "For where your treasure is, there your heart will be also.",
    ),
    Verse(
      verse: "Colossians 3:23",
      phrase: "Whatever you do, work at it with all your heart, as working for the Lord.",
    ),
    Verse(
      verse: "Micah 6:8",
      phrase: "Act justly, love mercy and walk humbly with your God.",
    ),

// Purpose and Life Calling
    Verse(
      verse: "Jeremiah 29:11",
      phrase: "For I know the plans I have for you, declares the Lord, plans for welfare and not for evil, to give you a future and a hope.",
    ),
    Verse(
      verse: "Ephesians 2:10",
      phrase: "For we are his workmanship, created in Christ Jesus for good works.",
    ),

// Dealing with Adversity
    Verse(
      verse: "Romans 8:28",
      phrase: "And we know that in all things God works for the good of those who love him.",
    ),
    Verse(
      verse: "James 1:2-3",
      phrase: "Consider it pure joy, my brothers and sisters, whenever you face trials of many kinds, because you know that the testing of your faith produces perseverance.",
    ),

// Leadership
    Verse(
      verse: "Proverbs 11:14",
      phrase: "Where there is no guidance, a people falls, but in an abundance of counselors there is safety.",
    ),
    Verse(
      verse: "Mark 10:45",
      phrase: "For even the Son of Man did not come to be served, but to serve.",
    ),

// Additional Verses
    Verse(
      verse: "Psalm 119:105",
      phrase: "Your word is a lamp to my feet and a light to my path.",
    ),
    Verse(
      verse: "Romans 12:2",
      phrase: "Do not conform to the pattern of this world, but be transformed by the renewing of your mind.",
    ),
    Verse(
      verse: "Galatians 5:22-23",
      phrase: "The fruit of the Spirit is love, joy, peace, patience, kindness, goodness, faithfulness, gentleness, self-control.",
    ),
    Verse(
      verse: "Matthew 28:19-20",
      phrase: "Go and make disciples of all nations, baptizing them and teaching them to obey everything I have commanded you.",
    ),
    Verse(
      verse: "Romans 5:8",
      phrase: "But God demonstrates his own love for us in this: While we were still sinners, Christ died for us.",
    ),
    Verse(
      verse: "Philippians 4:6",
      phrase: "Do not be anxious about anything, but in every situation, by prayer and petition, with thanksgiving, present your requests to God.",
    ),
    Verse(
      verse: "Isaiah 40:31",
      phrase: "But those who hope in the Lord will renew their strength. They will soar on wings like eagles.",
    ),
    Verse(
      verse: "Psalm 37:4",
      phrase: "Delight yourself in the Lord, and he will give you the desires of your heart.",
    ),
    Verse(
      verse: "1 Corinthians 10:13",
      phrase: "No temptation has overtaken you except what is common to mankind. And God is faithful.",
    ),
    Verse(
      verse: "Psalm 150:6",
      phrase: "Let everything that has breath praise the Lord.",
    ),
    Verse(
      verse: "John 14:6",
      phrase: "Jesus said, I am the way and the truth and the life. No one comes to the Father except through me.",
    ),
    Verse(
      verse: "Romans 6:23",
      phrase: "For the wages of sin is death, but the gift of God is eternal life in Christ Jesus our Lord.",
    ),
    Verse(
      verse: "Psalm 136:1",
      phrase: "Give thanks to the Lord, for he is good. His love endures forever.",
    ),
    Verse(
      verse: "Romans 8:38-39",
      phrase: "Neither death nor life, neither angels nor demons, can separate us from the love of God that is in Christ Jesus our Lord.",
    ),
    Verse(
      verse: "Matthew 22:37",
      phrase: "Love the Lord your God with all your heart and with all your soul and with all your mind.",
    ),
    Verse(
      verse: "Isaiah 41:10",
      phrase: "Do not fear, for I am with you; do not be dismayed, for I am your God.",
    ),
    Verse(
      verse: "2 Corinthians 5:17",
      phrase: "If anyone is in Christ, the new creation has come: The old has gone, the new is here.",
    ),
    Verse(
      verse: "Hebrews 13:8",
      phrase: "Jesus Christ is the same yesterday and today and forever.",
    ),
    Verse(
      verse: "Psalm 18:2",
      phrase: "The Lord is my rock, my fortress and my deliverer.",
    ),
    Verse(
      verse: "1 John 1:9",
      phrase: "If we confess our sins, he is faithful and just and will forgive us our sins and purify us from all unrighteousness.",
    ),
    Verse(
      verse: "Revelation 21:4",
      phrase: "He will wipe every tear from their eyes. There will be no more death or mourning or crying or pain.",
    ),
    Verse(
      verse: "Proverbs 3:6",
      phrase: "In all your ways submit to him, and he will make your paths straight.",
    ),
    Verse(
      verse: "John 10:10",
      phrase: "I have come that they may have life, and have it to the full.",
    ),
    Verse(
      verse: "Isaiah 53:5",
      phrase: "He was pierced for our transgressions, he was crushed for our iniquities.",
    ),
    Verse(
      verse: "Psalm 27:1",
      phrase: "The Lord is my light and my salvation, whom shall I fear.",
    ),
    Verse(
      verse: "Psalm 19:14",
      phrase: "May the words of my mouth and the meditation of my heart be pleasing to you, O Lord.",
    ),
    Verse(
      verse: "Romans 15:4",
      phrase: "Everything that was written in the past was written to teach us, so that through the endurance taught in the Scriptures we might have hope.",
    ),
    Verse(
      verse: "James 4:7",
      phrase: "Submit yourselves, then, to God. Resist the devil, and he will flee from you.",
    ),
    Verse(
      verse: "Psalm 119:11",
      phrase: "I have hidden your word in my heart that I might not sin against you.",
    ),
    Verse(
      verse: "Proverbs 18:10",
      phrase: "The name of the Lord is a fortified tower; the righteous run to it and are safe.",
    ),
    Verse(
      verse: "John 8:32",
      phrase: "Then you will know the truth, and the truth will set you free.",
    ),
    Verse(
      verse: "Psalm 34:8",
      phrase: "Taste and see that the Lord is good; blessed is the one who takes refuge in him.",
    ),
    Verse(
      verse: "Romans 10:9",
      phrase: "If you declare with your mouth, Jesus is Lord, and believe in your heart that God raised him from the dead, you will be saved.",
    ),
    Verse(
      verse: "Psalm 28:7",
      phrase: "The Lord is my strength and my shield; my heart trusts in him, and he helps me.",
    ),
    Verse(
      verse: "Psalm 37:5",
      phrase: "Commit your way to the Lord; trust in him and he will do this.",
    ),
    Verse(
      verse: "John 15:12",
      phrase: "This is my commandment, Love each other as I have loved you.",
    ),
    Verse(
      verse: "Romans 12:12",
      phrase: "Be joyful in hope, patient in affliction, faithful in prayer.",
    ),
    Verse(
      verse: "Psalm 56:3",
      phrase: "When I am afraid, I put my trust in you.",
    ),
    Verse(
      verse: "Philippians 4:8",
      phrase: "Whatever is true, whatever is noble, whatever is right, think about such things.",
    ),
    Verse(
      verse: "Psalm 16:8",
      phrase: "I keep my eyes always on the Lord. With him at my right hand, I will not be shaken.",
    ),
    // Spiritual Growth and Virtues
    Verse(
      verse: "Psalm 119:105",
      phrase: "Your word is a lamp to my feet and a light to my path.",
    ),
    Verse(
      verse: "James 1:5",
      phrase: "If any of you lacks wisdom, you should ask God, who gives generously to all without finding fault, and it will be given to you.",
    ),
    Verse(
      verse: "1 Peter 5:7",
      phrase: "Cast all your anxiety on him because he cares for you.",
    ),
    Verse(
      verse: "2 Corinthians 12:9",
      phrase: "My grace is sufficient for you, for my power is made perfect in weakness.",
    ),

// Personal Development and Well-being
    Verse(
      verse: "Psalm 139:14",
      phrase: "I praise you because I am fearfully and wonderfully made.",
    ),
    Verse(
      verse: "Proverbs 16:3",
      phrase: "Commit to the Lord whatever you do, and he will establish your plans.",
    ),
    Verse(
      verse: "Isaiah 26:3",
      phrase: "You will keep in perfect peace those whose minds are steadfast, because they trust in you.",
    ),

// Relationships and Community
    Verse(
      verse: "1 John 4:7",
      phrase: "Dear friends, let us love one another, for love comes from God.",
    ),
    Verse(
      verse: "Proverbs 15:1",
      phrase: "A gentle answer turns away wrath, but a harsh word stirs up anger.",
    ),
    Verse(
      verse: "Hebrews 10:24-25",
      phrase: "And let us consider how we may spur one another on toward love and good deeds, not giving up meeting together.",
    ),

// Practical Living and Ethics
    Verse(
      verse: "Luke 6:31",
      phrase: "Do to others as you would have them do to you.",
    ),
    Verse(
      verse: "Proverbs 11:25",
      phrase: "A generous person will prosper; whoever refreshes others will be refreshed.",
    ),
    Verse(
      verse: "Micah 7:18",
      phrase: "Who is a God like you, who pardons sin and forgives the transgression of the remnant of his inheritance?",
    ),

// Purpose and Life Calling
    Verse(
      verse: "Ecclesiastes 3:1",
      phrase: "There is a time for everything, and a season for every activity under the heavens.",
    ),
    Verse(
      verse: "Romans 8:14",
      phrase: "For those who are led by the Spirit of God are the children of God.",
    ),

// Dealing with Adversity
    Verse(
      verse: "Psalm 34:18",
      phrase: "The Lord is close to the brokenhearted and saves those who are crushed in spirit.",
    ),
    Verse(
      verse: "1 Corinthians 16:14",
      phrase: "Do everything in love.",
    ),
    Verse(
      verse: "Romans 5:3-4",
      phrase: "We also glory in our sufferings, because we know that suffering produces perseverance; perseverance, character; and character, hope.",
    ),

// Leadership
    Verse(
      verse: "Proverbs 4:7",
      phrase: "Wisdom is the principal thing; therefore get wisdom. And in all your getting, get understanding.",
    ),
    Verse(
      verse: "Luke 22:26",
      phrase: "But you are not to be like that. Instead, the greatest among you should be like the youngest, and the one who rules like the one who serves.",
    ),

// Additional Verses
    Verse(
      verse: "Psalm 90:12",
      phrase: "Teach us to number our days, that we may gain a heart of wisdom.",
    ),
    Verse(
      verse: "Matthew 5:16",
      phrase: "Let your light shine before others, that they may see your good deeds and glorify your Father in heaven.",
    ),
    Verse(
      verse: "Galatians 6:9",
      phrase: "Let us not become weary in doing good, for at the proper time we will reap a harvest if we do not give up.",
    ),
    Verse(
      verse: "Psalm 37:7",
      phrase: "Be still before the Lord and wait patiently for him.",
    ),
    Verse(
      verse: "John 14:27",
      phrase: "Peace I leave with you; my peace I give you. Not as the world gives do I give to you. Let not your hearts be troubled, neither let them be afraid.",
    ),
    Verse(
      verse: "Psalm 20:4",
      phrase: "May he give you the desire of your heart and make all your plans succeed.",
    ),
    Verse(
      verse: "Isaiah 40:29",
      phrase: "He gives strength to the weary and increases the power of the weak.",
    ),
    Verse(
      verse: "1 Corinthians 6:19-20",
      phrase: "Do you not know that your bodies are temples of the Holy Spirit, who is in you, whom you have received from God? You are not your own; you were bought at a price.",
    ),
    Verse(
      verse: "1 Thessalonians 5:18",
      phrase: "Give thanks in all circumstances; for this is God's will for you in Christ Jesus.",
    ),
    Verse(
      verse: "Psalm 31:24",
      phrase: "Be strong and take heart, all you who hope in the Lord.",
    ),
    Verse(
      verse: "Proverbs 3:6",
      phrase: "In all your ways acknowledge him, and he will make straight your paths.",
    ),
    Verse(
      verse: "Isaiah 43:2",
      phrase: "When you pass through the waters, I will be with you; and when you pass through the rivers, they will not sweep over you.",
    ),
    Verse(
      verse: "Psalm 138:8",
      phrase: "The Lord will fulfill his purpose for me; your steadfast love, O Lord, endures forever.",
    ),
    Verse(
      verse: "Galatians 5:14",
      phrase: "For the entire law is fulfilled in keeping this one command: Love your neighbor as yourself.",
    ),
    Verse(
      verse: "Psalm 51:10",
      phrase: "Create in me a pure heart, O God, and renew a steadfast spirit within me.",
    ),
    Verse(
      verse: "Psalm 73:26",
      phrase: "My flesh and my heart may fail, but God is the strength of my heart and my portion forever.",
    ),
    Verse(
      verse: "Romans 8:18",
      phrase: "I consider that our present sufferings are not worth comparing with the glory that will be revealed in us.",
    ),
    Verse(
      verse: "Philippians 1:6",
      phrase: "Being confident of this, that he who began a good work in you will carry it on to completion until the day of Christ Jesus.",
    ),
    Verse(
      verse: "Psalm 145:9",
      phrase: "The Lord is good to all; he has compassion on all he has made.",
    ),
    Verse(
      verse: "Isaiah 54:10",
      phrase: "Though the mountains be shaken and the hills be removed, yet my unfailing love for you will not be shaken.",
    ),
    Verse(
      verse: "Psalm 16:11",
      phrase: "You make known to me the path of life; you will fill me with joy in your presence, with eternal pleasures at your right hand.",
    ),
    Verse(
      verse: "Proverbs 16:9",
      phrase: "In their hearts humans plan their course, but the Lord establishes their steps.",
    ),
    Verse(
      verse: "Romans 8:31",
      phrase: "If God is for us, who can be against us?",
    ),
    Verse(
      verse: "Psalm 143:8",
      phrase: "Let the morning bring me word of your unfailing love, for I have put my trust in you.",
    ),
    Verse(
      verse: "Romans 14:8",
      phrase: "If we live, we live for the Lord; and if we die, we die for the Lord. So, whether we live or die, we belong to the Lord.",
    ),
    Verse(
      verse: "Psalm 62:7",
      phrase: "My salvation and my honor depend on God; he is my mighty rock, my refuge.",
    ),
    Verse(
      verse: "Romans 12:15",
      phrase: "Rejoice with those who rejoice; mourn with those who mourn.",
    ),
    Verse(
      verse: "Psalm 147:3",
      phrase: "He heals the brokenhearted and binds up their wounds.",
    ),
    Verse(
      verse: "Romans 12:9",
      phrase: "Love must be sincere. Hate what is evil; cling to what is good.",
    ),
    Verse(
      verse: "Psalm 42:11",
      phrase: "Why, my soul, are you downcast? Put your hope in God, for I will yet praise him, my Savior and my God.",
    ),
    Verse(
      verse: "1 Corinthians 15:58",
      phrase: "Stand firm. Let nothing move you. Always give yourselves fully to the work of the Lord, because you know that your labor in the Lord is not in vain.",
    ),
    Verse(
      verse: "Psalm 118:24",
      phrase: "This is the day the Lord has made; let us rejoice and be glad in it.",
    ),
    Verse(
      verse: "Psalm 119:89",
      phrase: "Your word, Lord, is eternal; it stands firm in the heavens.",
    ),
    Verse(
      verse: "Psalm 136:1",
      phrase: "Give thanks to the Lord, for he is good. His love endures forever.",
    ),
    Verse(
      verse: "Isaiah 12:2",
      phrase: "Surely God is my salvation; I will trust and not be afraid.",
    ),

  ];

  static Verse getRandomVerse() {
    final random = Random();
    final index = random.nextInt(verses.length);
    return verses[index];
  }
}

class PhraseRepository {

  static final List<Verse> wisdomVerses = [
    Verse(
      verse: "Philippians 4:7",
      phrase: "And the peace of God, which transcends all understanding, will guard your hearts and your minds in Christ Jesus.",
    ),
  ];

  static final List<Verse> loveVerses = [
    Verse(
      verse: "Philippians 4:7",
      phrase: "And the peace of God, which transcends all understanding, will guard your hearts and your minds in Christ Jesus.",
    ),
  ];

  static final List<Verse> motiveVerses = [
    Verse(
      verse: "Philippians 4:7",
      phrase: "And the peace of God, which transcends all understanding, will guard your hearts and your minds in Christ Jesus.",
    ),
  ];

  static final List<Verse> wealthVerses = [
    Verse(
      verse: "Philippians 4:7",
      phrase: "And the peace of God, which transcends all understanding, will guard your hearts and your minds in Christ Jesus.",
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
      'Wealth': wealthVerses,
      'Love': loveVerses,
      'Motivation': motiveVerses,
      'Wisdom': wisdomVerses,
    };
  }
}
