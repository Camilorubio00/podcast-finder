import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:podcast_finder/core/theme/app_colors.dart';
import 'package:podcast_finder/features/home/presentation/widgets/podcast_card.dart';
import '../../fixtures/podcast_fixtures.dart';

void main() {
  Widget makeTestableWidget(Widget child) {
    return MaterialApp(home: Scaffold(body: child));
  }

  group('PodcastCard Technical Specifications', () {
    
    testWidgets('Structure - Should have 12px radius and 1px border #DEE2E6', (tester) async {
      await tester.pumpWidget(makeTestableWidget(PodcastCard(podcast: PodcastFixtures.mockFirstPodcast)));

      final card = tester.widget<Card>(find.byType(Card));
      final shape = card.shape as RoundedRectangleBorder;

      expect(shape.borderRadius, BorderRadius.circular(12));
      expect(shape.side.width, 1);
      expect(shape.side.color, AppColors.border);
    });

    testWidgets('Left Section - Image should be 80x80 with 8px radius', (tester) async {
      await tester.pumpWidget(makeTestableWidget(PodcastCard(podcast: PodcastFixtures.mockFirstPodcast)));

      final imageContainer = tester.widget<SizedBox>(
        find.descendant(of: find.byType(CachedNetworkImage), matching: find.byType(SizedBox)).first
      );
      
      expect(imageContainer.width, 80);
      expect(imageContainer.height, 80);

      final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect).first);
      expect(clipRRect.borderRadius, BorderRadius.circular(8));
    });

    testWidgets('Title - Should match 16px, Semi-bold (600), #212529 and MaxLines 2', (tester) async {
      await tester.pumpWidget(makeTestableWidget(PodcastCard(podcast: PodcastFixtures.mockFirstPodcast)));

      final titleText = tester.widget<Text>(find.text(PodcastFixtures.mockFirstPodcast.title));
      
      expect(titleText.style?.fontSize, 16);
      expect(titleText.style?.fontWeight, FontWeight.w600);
      expect(titleText.style?.color, AppColors.textPrimary);
      expect(titleText.maxLines, 2);
      expect(titleText.overflow, TextOverflow.ellipsis);
    });

    testWidgets('Publisher - Should match 14px, #6C757D and MaxLines 1', (tester) async {
      await tester.pumpWidget(makeTestableWidget(PodcastCard(podcast: PodcastFixtures.mockFirstPodcast)));

      final publisherText = tester.widget<Text>(find.text(PodcastFixtures.mockFirstPodcast.publisher));
      
      expect(publisherText.style?.fontSize, 14);
      expect(publisherText.style?.color, AppColors.textSecondary);
      expect(publisherText.maxLines, 1);
    });

    testWidgets('Description - Should match 13px, #ADB5BD and MaxLines 2', (tester) async {
      await tester.pumpWidget(makeTestableWidget(PodcastCard(podcast: PodcastFixtures.mockFirstPodcast)));

      final descText = tester.widget<Text>(find.text(PodcastFixtures.mockFirstPodcast.description!));
      
      expect(descText.style?.fontSize, 13);
      expect(descText.style?.color, AppColors.textTertiary);
      expect(descText.maxLines, 2);
      expect(descText.overflow, TextOverflow.ellipsis);
    });

    testWidgets('Chevron Icon - Should be #ADB5BD', (tester) async {
      await tester.pumpWidget(makeTestableWidget(PodcastCard(podcast: PodcastFixtures.mockFirstPodcast)));

      final icon = tester.widget<Icon>(find.byIcon(Icons.chevron_right));
      expect(icon.color, AppColors.textTertiary);
    });
  });

  group('PodcastCard Contain', () {
    testWidgets('Should show the podcast information correctly', (
      tester,
    ) async {
      await tester.pumpWidget(
        makeTestableWidget(
          PodcastCard(podcast: PodcastFixtures.mockFirstPodcast),
        ),
      );

      expect(find.text('Tech Talk Daily'), findsOneWidget);
      expect(find.text('Tech Media Inc'), findsOneWidget);
      expect(
        find.text(
          'Your daily dose of technology news and insights. We cover everything from startups to AI.',
        ),
        findsOneWidget,
      );
      expect(find.byType(CachedNetworkImage), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('Should execute onTap when the card is pressed', (
      tester,
    ) async {
      bool tapped = false;

      await tester.pumpWidget(
        makeTestableWidget(
          PodcastCard(
            podcast: PodcastFixtures.mockFirstPodcast,
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('Should not show the description if it is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        makeTestableWidget(
          PodcastCard(podcast: PodcastFixtures.mockPodcastNoDesc),
        ),
      );

      expect(find.text('A podcast about Flutter.'), findsNothing);
    });
  });
}
