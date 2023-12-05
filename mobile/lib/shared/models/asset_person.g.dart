// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_person.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAssetPersonCollection on Isar {
  IsarCollection<AssetPerson> get assetPersons => this.collection();
}

const AssetPersonSchema = CollectionSchema(
  name: r'AssetPerson',
  id: -7511960018740336056,
  properties: {
    r'assetId': PropertySchema(
      id: 0,
      name: r'assetId',
      type: IsarType.long,
    ),
    r'peopleId': PropertySchema(
      id: 1,
      name: r'peopleId',
      type: IsarType.long,
    )
  },
  estimateSize: _assetPersonEstimateSize,
  serialize: _assetPersonSerialize,
  deserialize: _assetPersonDeserialize,
  deserializeProp: _assetPersonDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _assetPersonGetId,
  getLinks: _assetPersonGetLinks,
  attach: _assetPersonAttach,
  version: '3.1.0+1',
);

int _assetPersonEstimateSize(
  AssetPerson object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _assetPersonSerialize(
  AssetPerson object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.assetId);
  writer.writeLong(offsets[1], object.peopleId);
}

AssetPerson _assetPersonDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AssetPerson(
    assetId: reader.readLong(offsets[0]),
    peopleId: reader.readLong(offsets[1]),
  );
  object.id = id;
  return object;
}

P _assetPersonDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _assetPersonGetId(AssetPerson object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _assetPersonGetLinks(AssetPerson object) {
  return [];
}

void _assetPersonAttach(
    IsarCollection<dynamic> col, Id id, AssetPerson object) {
  object.id = id;
}

extension AssetPersonQueryWhereSort
    on QueryBuilder<AssetPerson, AssetPerson, QWhere> {
  QueryBuilder<AssetPerson, AssetPerson, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AssetPersonQueryWhere
    on QueryBuilder<AssetPerson, AssetPerson, QWhereClause> {
  QueryBuilder<AssetPerson, AssetPerson, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AssetPersonQueryFilter
    on QueryBuilder<AssetPerson, AssetPerson, QFilterCondition> {
  QueryBuilder<AssetPerson, AssetPerson, QAfterFilterCondition> assetIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assetId',
        value: value,
      ));
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterFilterCondition>
      assetIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assetId',
        value: value,
      ));
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterFilterCondition> assetIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assetId',
        value: value,
      ));
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterFilterCondition> assetIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assetId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterFilterCondition> peopleIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'peopleId',
        value: value,
      ));
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterFilterCondition>
      peopleIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'peopleId',
        value: value,
      ));
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterFilterCondition>
      peopleIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'peopleId',
        value: value,
      ));
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterFilterCondition> peopleIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'peopleId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AssetPersonQueryObject
    on QueryBuilder<AssetPerson, AssetPerson, QFilterCondition> {}

extension AssetPersonQueryLinks
    on QueryBuilder<AssetPerson, AssetPerson, QFilterCondition> {}

extension AssetPersonQuerySortBy
    on QueryBuilder<AssetPerson, AssetPerson, QSortBy> {
  QueryBuilder<AssetPerson, AssetPerson, QAfterSortBy> sortByAssetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetId', Sort.asc);
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterSortBy> sortByAssetIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetId', Sort.desc);
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterSortBy> sortByPeopleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peopleId', Sort.asc);
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterSortBy> sortByPeopleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peopleId', Sort.desc);
    });
  }
}

extension AssetPersonQuerySortThenBy
    on QueryBuilder<AssetPerson, AssetPerson, QSortThenBy> {
  QueryBuilder<AssetPerson, AssetPerson, QAfterSortBy> thenByAssetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetId', Sort.asc);
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterSortBy> thenByAssetIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetId', Sort.desc);
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterSortBy> thenByPeopleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peopleId', Sort.asc);
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterSortBy> thenByPeopleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peopleId', Sort.desc);
    });
  }
}

extension AssetPersonQueryWhereDistinct
    on QueryBuilder<AssetPerson, AssetPerson, QDistinct> {
  QueryBuilder<AssetPerson, AssetPerson, QDistinct> distinctByAssetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assetId');
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QDistinct> distinctByPeopleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'peopleId');
    });
  }
}

extension AssetPersonQueryProperty
    on QueryBuilder<AssetPerson, AssetPerson, QQueryProperty> {
  QueryBuilder<AssetPerson, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AssetPerson, int, QQueryOperations> assetIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assetId');
    });
  }

  QueryBuilder<AssetPerson, int, QQueryOperations> peopleIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'peopleId');
    });
  }
}
