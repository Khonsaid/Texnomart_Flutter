import 'package:bloc/bloc.dart';
import 'package:texnomart/di/di.dart';

import '../../../../data/model/favaurite_model.dart';
import '../../../data/repository/AppRepository.dart';
import '../../../data/scource/locel/hive_helper.dart';
import '../../../data/scource/remote/response/base_response.dart';
import '../../../data/scource/remote/response/detail/available_stores/available_stores.dart';
import '../../../data/scource/remote/response/detail/characters/characters_response.dart';
import '../../../data/scource/remote/response/detail/description/description_response.dart';
import '../../../data/scource/remote/response/detail/detail/detail_response.dart';
import '../../../data/scource/remote/response/detail/info_partners/info_partners.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailState()) {
    final repository = getIt<AppRepository>();

    on<LoadDetailDataEvent>(
      (event, emit) async {
        final productId = event.productId;

        emit(state.copyWith(title: event.name));

        final List<dynamic> result = await Future.wait([
          repository.getCharacters(productId),
          repository.getDetail(productId),
          repository.getAddress(productId),
          repository.getDescription(productId)
          // productRepository.getInfoPartners()
        ]);

        final charactersResponse = result[0] as BaseResponse<CharactersResponse>;
        final detailResponse = result[1] as BaseResponse<DetailResponse>;
        final addressResponse = result[2] as BaseResponse<AddressResponse>;
        final descriptionResponse = result[3] as BaseResponse<DescriptionResponse>;
        // final partnersInfoResponse = result[3] as BaseResponse<InfoPlatformResponse>;

        final isLiked = await repository.hasFavourite(int.parse(productId));
        final isAdded = HiveHelper.hasBasketModel(int.parse(productId));
        emit(state.copyWith(
            // partnersInfoResponse: partnersInfoResponse.data,
            title: event.name,
            isLiked: isLiked,
            isAdded: isAdded,
            charactersResponse: charactersResponse.data,
            detailResponse: detailResponse.data,
            addressResponse: addressResponse.data,
            descriptionResponse: descriptionResponse.data));
      },
    );
    on<ClickLikeEvent>((event, emit) async {
      await repository.toggleFavourite(event.product);
      final isLiked = await repository.hasFavourite(event.product.productId ?? 0);
      emit(state.copyWith(isLiked: isLiked, isLikedChanged: true));
    });

    on<ClickAddEvent>((event, emit) {
      emit(state.copyWith(isAdded: true));
    });
  }
}
