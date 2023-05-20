List<String> categories = [
  'Design',
  'Development',
  'Business',
  'Office productivity',
  'Finance & Accounting',
  'IT & Software',
  'Marketing',
  'Photography',
];

// class TrainingData {
//   List<TrainingPostModel> posts = [
//     TrainingPostModel(
//       companyName: 'DeepBlue Company',
//       companyId: 'lHSP9DuFsfT8S6LMB2uiDKULR1Y2',
//       isVerifiedCompany: true,
//       companyProfileImage: 'assets/images/company_profile.jpg',
//       trainingPostDate: 'November 28, 2022 At 11:37 PM',
//       trainingTitle: 'Flutter & Dart - The Complete Guide [2023 Edition]',
//       trainingImage: 'assets/images/training_1.jpg',
//       tags: [
//         'Flutter',
//         'Dart',
//         'Mobile development',
//         'Android development',
//         'IOS development'
//       ],
//       rating: 4.5,
//       ratingStudent: 250,
//       requiredStudentNo: 50,
//       startingDate: 'June 16, 2023',
//       totalHours: 80,
//       hoursPerWeek: 10,
//       description:
//           // 'Discover some of the amazing things you can do with Perl 5, including downloading text and images from the internet(just like Zuckerberg in The Social Network), reformatting data, importing and exporting data to and from databases.',
//           'A Complete Guide to the Flutter SDK & Flutter Framework for building native iOS and Android apps',
//       learnedTitles: [
//         'Learn Flutter and Dart from the ground up, step-by-step.',
//         'Use features like Google Maps, the device camera, authentication and much more!',
//         'Learn all the basics without stopping after them: Dive deeply into Flutter & Dart and become an advanced developer',
//         'Build engaging native mobile apps for both Android and iOS',
//         'Learn how to upload images and how to send manual and automated push notifications',
//       ],
//       comments: [
//         CommentModel(
//           userName: 'John M.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'I have taken a few different courses on Flutter now, but I have to say that Max has gone above and beyond. His recent updates have made it an excellent resource and the best course overall for learning Flutter. Be prepared to be challenged, but if you work through the course you will be quite knowledgeable by the time you are done.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Noorus K.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'I think this course is for someone who already have some prior knowledge of flutter may be very basic, but overall course is really awesome and it really teaches everything in depth most importantly, it more focused on performance and best approach, but at the same time multiple possible possible ways of doing the same thing. Thanks Max',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'David A',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'Max does a nice job of getting the points across. I\'m looking forward to seeing some of the later, more advanced topics updated to a more current version of Flutter.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//       ],
//     ),
//     TrainingPostModel(
//       companyName: 'DeepBlue Company',
//       companyId: 'lHSP9DuFsfT8S6LMB2uiDKULR1Y2',
//       isVerifiedCompany: false,
//       companyProfileImage: 'assets/images/company_profile.jpg',
//       trainingPostDate: 'November 28, 2022 At 11:37 PM',
//       trainingTitle: 'The Complete 2023 Web Development Bootcamp',
//       trainingImage: 'assets/images/training_2.jpg',
//       tags: [
//         'Web Development',
//         'Front-End',
//         'Back-End',
//         'Full-Stack',
//         'HTML',
//         'CSS',
//         'Javascript',
//         'Node',
//         'React',
//         'MongoDB',
//         'Web3',
//         'DApps',
//       ],
//       rating: 4.7,
//       ratingStudent: 677,
//       requiredStudentNo: 35,
//       startingDate: 'June 16, 2023',
//       totalHours: 180,
//       hoursPerWeek: 20,
//       description:
//           // 'Discover some of the amazing things you can do with Perl 5, including downloading text and images from the internet(just like Zuckerberg in The Social Network), reformatting data, importing and exporting data to and from databases.',
//           'Become a Full-Stack Web Developer with just ONE Bootcamp. HTML, CSS, Javascript, Node, React, MongoDB, Web3 and DApps',
//       learnedTitles: [
//         'You will build 16 web development projects for your portfolio, ready to apply for junior developer jobs.',
//         'You will master both front and back-end development, becoming a full-stack developer by the end of the course.',
//         'Build fully-fledged websites and web apps for your startup or business.',
//         'Master frontend development with React.',
//         'Learn professional developer best practices.',
//         'You will learn the latest technologies, including Javascript, React, Node and even Web3 development.',
//         'After the course you will be able to build ANY website you want.',
//         'Work as a freelance web developer.',
//         'Master backend development with Node.',
//       ],
//       comments: [
//         CommentModel(
//           userName: 'Akshraj Vanrajsinh C.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'If You want to Learn Web dev in on place , you reached to right place.This is the best course on internet that i found Till now.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Onu Princeley T.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'My name is Onu Princeley Toochukwu. I want to say a very big thank you to Udemy management and Dr Angela Yu. This course is one of the best decisions i have taken in my life.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Mohammed T.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'it is really worth it to take this course inplace of a weekend pizza ,it can make u eligible to buy pizza everyday,the course structure is well design ,it is better than various courses in market that charge money in lakes',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Naman A.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'The course is absolutely phenomenal and I cannot be more thankful to Angela for teaching in such an awesome way. However, there are a few places where the lessons are broken (not at all complaining, it is still more worth a million times than what it costs) and it gets too difficult to follow along, such as the mongoose module and the web3 sections. The only reason for 4 stars',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//       ],
//     ),
//     TrainingPostModel(
//       companyName: 'DeepBlue Company',
//       companyId: 'lHSP9DuFsfT8S6LMB2uiDKULR1Y2',
//       isVerifiedCompany: true,
//       companyProfileImage: 'assets/images/company_profile.jpg',
//       trainingPostDate: 'November 28, 2022 At 11:37 PM',
//       trainingTitle: 'MongoDB - The Complete Developer\'s Guide 2023',
//       trainingImage: 'assets/images/training_3.jpg',
//       tags: [
//         'MongoDB',
//         'CRUD Operations',
//         'Indexes',
//         'Aggregation Framework',
//       ],
//       rating: 4.5,
//       ratingStudent: 250,
//       requiredStudentNo: 50,
//       startingDate: 'June 16, 2023',
//       totalHours: 200,
//       hoursPerWeek: 40,
//       description:
//           'Master MongoDB Development for Web & Mobile Apps. CRUD Operations, Indexes, Aggregation Framework - All about MongoDB!',
//       learnedTitles: [
//         'Learn what document databases are and how data is organized with MongoDB',
//         'Don\'t stop at the basics - learn all about writing complex MongoDB queries, in-depth and with practical examples!',
//         'Use all features MongoDB offers you to work with data efficiently',
//         'Learn how to perform CRUD operations with MongoDB',
//         'Write efficient and well-performing queries to fetch data in the format you need it',
//       ],
//       comments: [
//         CommentModel(
//           userName: 'Rishi B.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'Great course! Just towards the end, felt like focus shifted slightly away from MongoDB to the JS, React code and it became difficult to follow.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'ANIEBIET A.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'Really detailed and practical. It has really exceeded my expectations when I purchased the course. Max is a great teacher and I\'ve never been disappointed with any of his courses. ',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Shantanu D.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'Very good course! I got to learn everything about MongoDB from it! Although I found the shell and some services commands are a bit old but generally the teaching is still valid to date.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Hamklien A.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               ' really enjoyed this whole course, i highly recommend it, why?, because i feel like i really learnt about Mongo, since the whole course is focus on using the shell, which is a great success to understand.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//       ],
//     ),
//     TrainingPostModel(
//       companyName: 'DeepBlue Company',
//       companyId: 'lHSP9DuFsfT8S6LMB2uiDKULR1Y2',
//       isVerifiedCompany: true,
//       companyProfileImage: 'assets/images/company_profile.jpg',
//       trainingPostDate: 'November 28, 2022 At 11:37 PM',
//       trainingTitle: 'Java Programming Masterclass updated to Java 17',
//       trainingImage: 'assets/images/training_4.jpg',
//       tags: [
//         'Java',
//         'Java17',
//         'Programing',
//       ],
//       rating: 4.5,
//       ratingStudent: 173,
//       requiredStudentNo: 40,
//       startingDate: 'June 16, 2023',
//       totalHours: 100,
//       hoursPerWeek: 15,
//       description:
//           'Learn Java In This Training And Become a Computer Programmer. Obtain valuable Core Java Skills And Java Certification',
//       learnedTitles: [
//         ' Learn the core Java skills needed to apply for Java developer positions in just 14 hours.',
//         'Be able to demonstrate your understanding of Java to future employers.',
//         'Acquire essential java basics for transitioning to the Spring Framework, Java EE, Android development and more.',
//         'Be able to sit for and pass the Oracle Java Certificate exam if you choose.',
//         'Learn industry "best practices" in Java software development from a professional Java developer who has worked in the language for 18 years.',
//         'Obtain proficiency in Java 8 and Java 11.',
//       ],
//       comments: [
//         CommentModel(
//           userName: 'Martin C. F.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'Very clear and thorough. A bit long winded, but that is not bad when you can fast forward when necessary.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Michael B.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'I’m a professional software developer and took this course as refresher to update my Java skills. I learned Java more than 15 years ago and never used it since then. But now I need it for a new project',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Élio',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'This course could definitely use a big update.Most of the sections are outdated.But it is still a good starting point for someone new to programming.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Guy V.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'this course has taught me pretty much all of the important knowledge you need to know in the java language, very well designed course, the best java course out there.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//       ],
//     ),
//     TrainingPostModel(
//       companyName: 'DeepBlue Company',
//       companyId: 'lHSP9DuFsfT8S6LMB2uiDKULR1Y2',
//       isVerifiedCompany: true,
//       companyProfileImage: 'assets/images/company_profile.jpg',
//       trainingPostDate: 'November 28, 2022 At 11:37 PM',
//       trainingTitle: 'Data Structures and Algorithms: Deep Dive Using Java',
//       trainingImage: 'assets/images/training_5.jpg',
//       tags: [
//         'Data Structure',
//         'Algorithm',
//         'Arrays',
//         'Linked Lists',
//         'Trees',
//         'Hashtables',
//         'Stacks',
//         'Queues',
//         'Heaps',
//       ],
//       rating: 4.5,
//       ratingStudent: 539,
//       requiredStudentNo: 50,
//       startingDate: 'June 16, 2023',
//       totalHours: 120,
//       hoursPerWeek: 10,
//       description:
//           'Learn about Arrays, Linked Lists, Trees, Hashtables, Stacks, Queues, Heaps, Sort algorithms and Search algorithms',
//       learnedTitles: [
//         'Learn the strengths and weaknesses of a variety of data structures, so you can choose the best data structure for your data and applications',
//         'Learn many of the algorithms commonly used to sort data, so your applications will perform efficiently when sorting large datasets',
//         'Code an implementation of each data structure, so you understand how they work under the covers',
//         'Learn what’s available in the JDK for storing and sorting data, so you won’t waste time reinventing the wheel',
//       ],
//       comments: [
//         CommentModel(
//           userName: 'Ashwin G.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'Great course to get a clear idea with advanced concepts and explanation is good.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Matthew D.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'This course taught me a lot about what I came here for: an intermediate introduction to Data Structures and Algorithms using Java.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Rami Lawal M.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'This is an amazing, detailed and an in-depth course. This course really broke data structure, algorithms down in great details as it explains the inner workings of many algorithms and data structures. ',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//       ],
//     ),
//     TrainingPostModel(
//       companyName: 'DeepBlue Company',
//       companyId: 'lHSP9DuFsfT8S6LMB2uiDKULR1Y2',
//       isVerifiedCompany: true,
//       companyProfileImage: 'assets/images/company_profile.jpg',
//       trainingPostDate: 'November 28, 2022 At 11:37 PM',
//       trainingTitle: 'Python Django - The Practical Guide',
//       trainingImage: 'assets/images/training_6.jpg',
//       tags: [
//         'Web-Development',
//         'Django',
//         'python',
//       ],
//       rating: 4.7,
//       ratingStudent: 248,
//       requiredStudentNo: 45,
//       startingDate: 'June 16, 2023',
//       totalHours: 120,
//       hoursPerWeek: 20,
//       description:
//           'Learn how to build web applications and websites with Python and the Django framework',
//       learnedTitles: [
//         'Learn how to use Python for web development with Django',
//         'Choose between the full course or the included course summary to get you started quickly',
//         'Build real projects and apply what you learned in a full blog website created in the course',
//       ],
//       comments: [
//         CommentModel(
//           userName: 'Ahmet L.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'Unfortunately, the projects do not work well anymore. You have to solve a lot of issues. But look at the bright side; thanks to this course, i improved my troubleshooting capabilities',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Suraj A.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'It\'s just a start for my Django journey and I\'m loving it !!!!I have a project in my mind and this is the perfect course that has given me the insight which will be applied to make my brainchild a reality. Thanks Max',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Aditya A.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'Good course, presents the content with clarity and objectivity. For the 5 stars, it was necessary to delve a little more and present the Django Rest Framework.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//       ],
//     ),
//     // TrainingPostModel(
//     //   companyName: 'DeepBlue Company',
//     //   isVerifiedCompany: true,
//     //   companyProfileImage: 'assets/images/company_profile.jpg',
//     //   trainingPostDate: 'November 28, 2022 At 11:37 PM',
//     //   trainingTitle: '',
//     //   trainingImage: 'assets/images/training_7.jpg',
//     //   tags: [
//     //     '',
//     //     '',
//     //     '',
//     //     '',
//     //   ],
//     //   rating: 4.5,
//     //   ratingStudent: 250,
//     //   requiredStudentNo: 50,
//     //   startingDate: 'June 16, 2023',
//     //   totalHours: 80,
//     //   hoursPerWeek: 10,
//     //   description: '',
//     //   learnedTitles: [
//     //     '',
//     //     '',
//     //     '',
//     //     '',
//     //     '',
//     //     '',
//     //   ],
//     //   comments: [
//     //     CommentModel(
//     //       userName: '',
//     //       userProfileImage: 'assets/images/user_image.jpg',
//     //       comment: '',
//     //       commentDateTime:
//     //           DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//     //     ),
//     //     CommentModel(
//     //       userName: '',
//     //       userProfileImage: 'assets/images/user_image.jpg',
//     //       comment: '',
//     //       commentDateTime:
//     //           DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//     //     ),
//     //     CommentModel(
//     //       userName: '',
//     //       userProfileImage: 'assets/images/user_image.jpg',
//     //       comment: '',
//     //       commentDateTime:
//     //           DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//     //     ),
//     //     CommentModel(
//     //       userName: '',
//     //       userProfileImage: 'assets/images/user_image.jpg',
//     //       comment: '',
//     //       commentDateTime:
//     //           DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//     //     ),
//     //   ],
//     // ),
//     // TrainingPostModel(
//     //   companyName: 'DeepBlue Company',
//     //   isVerifiedCompany: true,
//     //   companyProfileImage: 'assets/images/company_profile.jpg',
//     //   trainingPostDate: 'November 28, 2022 At 11:37 PM',
//     //   trainingTitle: '',
//     //   trainingImage: 'assets/images/training_6.jpg',
//     //   tags: [
//     //     '',
//     //     '',
//     //     '',
//     //     '',
//     //   ],
//     //   rating: 4.5,
//     //   ratingStudent: 250,
//     //   requiredStudentNo: 50,
//     //   startingDate: 'June 16, 2023',
//     //   totalHours: 80,
//     //   hoursPerWeek: 10,
//     //   description:
//     //       // 'Discover some of the amazing things you can do with Perl 5, including downloading text and images from the internet(just like Zuckerberg in The Social Network), reformatting data, importing and exporting data to and from databases.',
//     //       '',
//     //   learnedTitles: [
//     //     '',
//     //     '',
//     //     '',
//     //     '',
//     //     '',
//     //     '',
//     //   ],
//     //   comments: [
//     //     CommentModel(
//     //       userName: '',
//     //       userProfileImage: 'assets/images/user_image.jpg',
//     //       comment: '',
//     //       commentDateTime:
//     //           DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//     //     ),
//     //     CommentModel(
//     //       userName: '',
//     //       userProfileImage: 'assets/images/user_image.jpg',
//     //       comment: '',
//     //       commentDateTime:
//     //           DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//     //     ),
//     //     CommentModel(
//     //       userName: '',
//     //       userProfileImage: 'assets/images/user_image.jpg',
//     //       comment: '',
//     //       commentDateTime:
//     //           DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//     //     ),
//     //     CommentModel(
//     //       userName: '',
//     //       userProfileImage: 'assets/images/user_image.jpg',
//     //       comment: '',
//     //       commentDateTime:
//     //           DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//     //     ),
//     //   ],
//     // ),
//     // TrainingPostModel(
//     //   companyName: 'DeepBlue Company',
//     //   isVerifiedCompany: true,
//     //   companyProfileImage: 'assets/images/company_profile.jpg',
//     //   trainingPostDate: 'November 28, 2022 At 11:37 PM',
//     //   trainingTitle: '',
//     //   trainingImage: 'assets/images/training_6.jpg',
//     //   tags: [
//     //     '',
//     //     '',
//     //     '',
//     //     '',
//     //   ],
//     //   rating: 4.5,
//     //   ratingStudent: 250,
//     //   requiredStudentNo: 50,
//     //   startingDate: 'June 16, 2023',
//     //   totalHours: 80,
//     //   hoursPerWeek: 10,
//     //   description:
//     //       // 'Discover some of the amazing things you can do with Perl 5, including downloading text and images from the internet(just like Zuckerberg in The Social Network), reformatting data, importing and exporting data to and from databases.',
//     //       '',
//     //   learnedTitles: [
//     //     '',
//     //     '',
//     //     '',
//     //     '',
//     //     '',
//     //     '',
//     //   ],
//     //   comments: [
//     //     CommentModel(
//     //       userName: '',
//     //       userProfileImage: 'assets/images/user_image.jpg',
//     //       comment: '',
//     //       commentDateTime:
//     //           DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//     //     ),
//     //     CommentModel(
//     //       userName: '',
//     //       userProfileImage: 'assets/images/user_image.jpg',
//     //       comment: '',
//     //       commentDateTime:
//     //           DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//     //     ),
//     //     CommentModel(
//     //       userName: '',
//     //       userProfileImage: 'assets/images/user_image.jpg',
//     //       comment: '',
//     //       commentDateTime:
//     //           DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//     //     ),
//     //     CommentModel(
//     //       userName: '',
//     //       userProfileImage: 'assets/images/user_image.jpg',
//     //       comment: '',
//     //       commentDateTime:
//     //           DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//     //     ),
//     //   ],
//     // ),
//     TrainingPostModel(
//       companyName: 'DeepBlue Company',
//       companyId: 'lHSP9DuFsfT8S6LMB2uiDKULR1Y2',
//       isVerifiedCompany: true,
//       companyProfileImage: 'assets/images/company_profile.jpg',
//       trainingPostDate: 'November 28, 2022 At 11:37 PM',
//       trainingTitle: 'Flutter & Dart - The Complete Guide [2023 Edition]',
//       trainingImage: 'assets/images/training_1.jpg',
//       tags: [
//         'Flutter',
//         'Dart',
//         'Mobile development',
//         'Android development',
//         'IOS development'
//       ],
//       rating: 4.5,
//       ratingStudent: 250,
//       requiredStudentNo: 50,
//       startingDate: 'June 16, 2023',
//       totalHours: 80,
//       hoursPerWeek: 10,
//       description:
//           // 'Discover some of the amazing things you can do with Perl 5, including downloading text and images from the internet(just like Zuckerberg in The Social Network), reformatting data, importing and exporting data to and from databases.',
//           'A Complete Guide to the Flutter SDK & Flutter Framework for building native iOS and Android apps',
//       learnedTitles: [
//         'Learn Flutter and Dart from the ground up, step-by-step',
//         'Use features like Google Maps, the device camera, authentication and much more!',
//         'Learn all the basics without stopping after them: Dive deeply into Flutter & Dart and become an advanced developer',
//         'Build engaging native mobile apps for both Android and iOS',
//         'Learn how to upload images and how to send manual and automated push notifications',
//       ],
//       comments: [
//         CommentModel(
//           userName: 'John M.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'I have taken a few different courses on Flutter now, but I have to say that Max has gone above and beyond. His recent updates have made it an excellent resource and the best course overall for learning Flutter. Be prepared to be challenged, but if you work through the course you will be quite knowledgeable by the time you are done.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Noorus K.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'I think this course is for someone who already have some prior knowledge of flutter may be very basic, but overall course is really awesome and it really teaches everything in depth most importantly, it more focused on performance and best approach, but at the same time multiple possible possible ways of doing the same thing. Thanks Max',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'David A',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'Max does a nice job of getting the points across. I\'m looking forward to seeing some of the later, more advanced topics updated to a more current version of Flutter.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//       ],
//     ),
//     TrainingPostModel(
//       companyName: 'DeepBlue Company',
//       companyId: 'lHSP9DuFsfT8S6LMB2uiDKULR1Y2',
//       isVerifiedCompany: false,
//       companyProfileImage: 'assets/images/company_profile.jpg',
//       trainingPostDate: 'November 28, 2022 At 11:37 PM',
//       trainingTitle: 'The Complete 2023 Web Development Bootcamp',
//       trainingImage: 'assets/images/training_2.jpg',
//       tags: [
//         'Web Development',
//         'Front-End',
//         'Back-End',
//         'Full-Stack',
//         'HTML',
//         'CSS',
//         'Javascript',
//         'Node',
//         'React',
//         'MongoDB',
//         'Web3',
//         'DApps',
//       ],
//       rating: 4.7,
//       ratingStudent: 677,
//       requiredStudentNo: 35,
//       startingDate: 'June 16, 2023',
//       totalHours: 180,
//       hoursPerWeek: 20,
//       description:
//           // 'Discover some of the amazing things you can do with Perl 5, including downloading text and images from the internet(just like Zuckerberg in The Social Network), reformatting data, importing and exporting data to and from databases.',
//           'Become a Full-Stack Web Developer with just ONE Bootcamp. HTML, CSS, Javascript, Node, React, MongoDB, Web3 and DApps',
//       learnedTitles: [
//         'You will build 16 web development projects for your portfolio, ready to apply for junior developer jobs.',
//         'You will master both front and back-end development, becoming a full-stack developer by the end of the course.',
//         'Build fully-fledged websites and web apps for your startup or business.',
//         'Master frontend development with React',
//         'Learn professional developer best practices.',
//         'You will learn the latest technologies, including Javascript, React, Node and even Web3 development.',
//         'After the course you will be able to build ANY website you want.',
//         'Work as a freelance web developer.',
//         'Master backend development with Node',
//       ],
//       comments: [
//         CommentModel(
//           userName: 'Akshraj Vanrajsinh C.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'If You want to Learn Web dev in on place , you reached to right place.This is the best course on internet that i found Till now.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Onu Princeley T.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'My name is Onu Princeley Toochukwu. I want to say a very big thank you to Udemy management and Dr Angela Yu. This course is one of the best decisions i have taken in my life.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Mohammed T.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'it is really worth it to take this course inplace of a weekend pizza ,it can make u eligible to buy pizza everyday,the course structure is well design ,it is better than various courses in market that charge money in lakes',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Naman A.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'The course is absolutely phenomenal and I cannot be more thankful to Angela for teaching in such an awesome way. However, there are a few places where the lessons are broken (not at all complaining, it is still more worth a million times than what it costs) and it gets too difficult to follow along, such as the mongoose module and the web3 sections. The only reason for 4 stars',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//       ],
//     ),
//     TrainingPostModel(
//       companyName: 'DeepBlue Company',
//       companyId: 'lHSP9DuFsfT8S6LMB2uiDKULR1Y2',
//       isVerifiedCompany: true,
//       companyProfileImage: 'assets/images/company_profile.jpg',
//       trainingPostDate: 'November 28, 2022 At 11:37 PM',
//       trainingTitle: 'MongoDB - The Complete Developer\'s Guide 2023',
//       trainingImage: 'assets/images/training_3.jpg',
//       tags: [
//         'MongoDB',
//         'CRUD Operations',
//         'Indexes',
//         'Aggregation Framework',
//       ],
//       rating: 4.5,
//       ratingStudent: 250,
//       requiredStudentNo: 50,
//       startingDate: 'June 16, 2023',
//       totalHours: 200,
//       hoursPerWeek: 40,
//       description:
//           'Master MongoDB Development for Web & Mobile Apps. CRUD Operations, Indexes, Aggregation Framework - All about MongoDB!',
//       learnedTitles: [
//         'Learn what document databases are and how data is organized with MongoDB',
//         'Don\'t stop at the basics - learn all about writing complex MongoDB queries, in-depth and with practical examples!',
//         'Use all features MongoDB offers you to work with data efficiently',
//         'Learn how to perform CRUD operations with MongoDB',
//         'Write efficient and well-performing queries to fetch data in the format you need it',
//       ],
//       comments: [
//         CommentModel(
//           userName: 'Rishi B.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'Great course! Just towards the end, felt like focus shifted slightly away from MongoDB to the JS, React code and it became difficult to follow.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'ANIEBIET A.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'Really detailed and practical. It has really exceeded my expectations when I purchased the course. Max is a great teacher and I\'ve never been disappointed with any of his courses. ',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Shantanu D.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'Very good course! I got to learn everything about MongoDB from it! Although I found the shell and some services commands are a bit old but generally the teaching is still valid to date.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Hamklien A.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               ' really enjoyed this whole course, i highly recommend it, why?, because i feel like i really learnt about Mongo, since the whole course is focus on using the shell, which is a great success to understand.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//       ],
//     ),
//     TrainingPostModel(
//       companyName: 'DeepBlue Company',
//       companyId: 'lHSP9DuFsfT8S6LMB2uiDKULR1Y2',
//       isVerifiedCompany: true,
//       companyProfileImage: 'assets/images/company_profile.jpg',
//       trainingPostDate: 'November 28, 2022 At 11:37 PM',
//       trainingTitle: 'Java Programming Masterclass updated to Java 17',
//       trainingImage: 'assets/images/training_4.jpg',
//       tags: [
//         'Java',
//         'Java17',
//         'Programing',
//       ],
//       rating: 4.5,
//       ratingStudent: 173,
//       requiredStudentNo: 40,
//       startingDate: 'June 16, 2023',
//       totalHours: 100,
//       hoursPerWeek: 15,
//       description:
//           'Learn Java In This Training And Become a Computer Programmer. Obtain valuable Core Java Skills And Java Certification',
//       learnedTitles: [
//         'Learn the core Java skills needed to apply for Java developer positions in just 14 hours.',
//         'Be able to demonstrate your understanding of Java to future employers.',
//         'Acquire essential java basics for transitioning to the Spring Framework, Java EE, Android development and more.',
//         'Be able to sit for and pass the Oracle Java Certificate exam if you choose.',
//         'Learn industry "best practices" in Java software development from a professional Java developer who has worked in the language for 18 years.',
//         'Obtain proficiency in Java 8 and Java 11.',
//       ],
//       comments: [
//         CommentModel(
//           userName: 'Martin C. F.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'Very clear and thorough. A bit long winded, but that is not bad when you can fast forward when necessary.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Michael B.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'I’m a professional software developer and took this course as refresher to update my Java skills. I learned Java more than 15 years ago and never used it since then. But now I need it for a new project',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Élio',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'This course could definitely use a big update.Most of the sections are outdated.But it is still a good starting point for someone new to programming.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Guy V.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'this course has taught me pretty much all of the important knowledge you need to know in the java language, very well designed course, the best java course out there.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//       ],
//     ),
//     TrainingPostModel(
//       companyName: 'DeepBlue Company',
//       companyId: 'lHSP9DuFsfT8S6LMB2uiDKULR1Y2',
//       isVerifiedCompany: true,
//       companyProfileImage: 'assets/images/company_profile.jpg',
//       trainingPostDate: 'November 28, 2022 At 11:37 PM',
//       trainingTitle: 'Data Structures and Algorithms: Deep Dive Using Java',
//       trainingImage: 'assets/images/training_5.jpg',
//       tags: [
//         'Data Structure',
//         'Algorithm',
//         'Arrays',
//         'Linked Lists',
//         'Trees',
//         'Hashtables',
//         'Stacks',
//         'Queues',
//         'Heaps',
//       ],
//       rating: 4.5,
//       ratingStudent: 539,
//       requiredStudentNo: 50,
//       startingDate: 'June 16, 2023',
//       totalHours: 120,
//       hoursPerWeek: 10,
//       description:
//           'Learn about Arrays, Linked Lists, Trees, Hashtables, Stacks, Queues, Heaps, Sort algorithms and Search algorithms',
//       learnedTitles: [
//         'Learn the strengths and weaknesses of a variety of data structures, so you can choose the best data structure for your data and applications',
//         'Learn many of the algorithms commonly used to sort data, so your applications will perform efficiently when sorting large datasets',
//         'Code an implementation of each data structure, so you understand how they work under the covers',
//         'Learn what’s available in the JDK for storing and sorting data, so you won’t waste time reinventing the wheel',
//       ],
//       comments: [
//         CommentModel(
//           userName: 'Ashwin G.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'Great course to get a clear idea with advanced concepts and explanation is good.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Matthew D.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'This course taught me a lot about what I came here for: an intermediate introduction to Data Structures and Algorithms using Java.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Rami Lawal M.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'This is an amazing, detailed and an in-depth course. This course really broke data structure, algorithms down in great details as it explains the inner workings of many algorithms and data structures. ',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//       ],
//     ),
//     TrainingPostModel(
//       companyName: 'DeepBlue Company',
//       companyId: 'lHSP9DuFsfT8S6LMB2uiDKULR1Y2',
//       isVerifiedCompany: true,
//       companyProfileImage: 'assets/images/company_profile.jpg',
//       trainingPostDate: 'November 28, 2022 At 11:37 PM',
//       trainingTitle: 'Python Django - The Practical Guide',
//       trainingImage: 'assets/images/training_6.jpg',
//       tags: [
//         'Web-Development',
//         'Django',
//         'python',
//       ],
//       rating: 4.7,
//       ratingStudent: 248,
//       requiredStudentNo: 45,
//       startingDate: 'June 16, 2023',
//       totalHours: 120,
//       hoursPerWeek: 20,
//       description:
//           'Learn how to build web applications and websites with Python and the Django framework',
//       learnedTitles: [
//         'Learn how to use Python for web development with Django',
//         'Choose between the full course or the included course summary to get you started quickly',
//         'Build real projects and apply what you learned in a full blog website created in the course',
//       ],
//       comments: [
//         CommentModel(
//           userName: 'Ahmet L.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'Unfortunately, the projects do not work well anymore. You have to solve a lot of issues. But look at the bright side; thanks to this course, i improved my troubleshooting capabilities',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Suraj A.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'It\'s just a start for my Django journey and I\'m loving it !!!!I have a project in my mind and this is the perfect course that has given me the insight which will be applied to make my brainchild a reality. Thanks Max',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//         CommentModel(
//           userName: 'Aditya A.',
//           userProfileImage: 'assets/images/user_image.jpg',
//           comment:
//               'Good course, presents the content with clarity and objectivity. For the 5 stars, it was necessary to delve a little more and present the Django Rest Framework.',
//           commentDateTime:
//               DateFormat('MMMM d, yyyy At h:mm a').format(DateTime.now()),
//         ),
//       ],
//     ),
//   ];
// }
