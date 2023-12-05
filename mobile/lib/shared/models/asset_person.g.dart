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
  properties: {},
  estimateSize: _assetPersonEstimateSize,
  serialize: _assetPersonSerialize,
  deserialize: _assetPersonDeserialize,
  deserializeProp: _assetPersonDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'asset': LinkSchema(
      id: -5760304866653576750,
      name: r'asset',
      target: r'Asset',
      single: true,
    ),
    r'person': LinkSchema(
      id: 7845466883478273504,
      name: r'person',
      target: r'Person',
      single: true,
    )
  },
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
) {}
AssetPerson _assetPersonDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AssetPerson();
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _assetPersonGetId(AssetPerson object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _assetPersonGetLinks(AssetPerson object) {
  return [object.asset, object.person];
}

void _assetPersonAttach(
    IsarCollection<dynamic> col, Id id, AssetPerson object) {
  object.id = id;
  object.asset.attach(col, col.isar.collection<Asset>(), r'asset', id);
  object.person.attach(col, col.isar.collection<Person>(), r'person', id);
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
}

extension AssetPersonQueryObject
    on QueryBuilder<AssetPerson, AssetPerson, QFilterCondition> {}

extension AssetPersonQueryLinks
    on QueryBuilder<AssetPerson, AssetPerson, QFilterCondition> {
  QueryBuilder<AssetPerson, AssetPerson, QAfterFilterCondition> asset(
      FilterQuery<Asset> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'asset');
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterFilterCondition> assetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'asset', 0, true, 0, true);
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterFilterCondition> person(
      FilterQuery<Person> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'person');
    });
  }

  QueryBuilder<AssetPerson, AssetPerson, QAfterFilterCondition> personIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'person', 0, true, 0, true);
    });
  }
}

extension AssetPersonQuerySortBy
    on QueryBuilder<AssetPerson, AssetPerson, QSortBy> {}

extension AssetPersonQuerySortThenBy
    on QueryBuilder<AssetPerson, AssetPerson, QSortThenBy> {
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
}

extension AssetPersonQueryWhereDistinct
    on QueryBuilder<AssetPerson, AssetPerson, QDistinct> {}

extension AssetPersonQueryProperty
    on QueryBuilder<AssetPerson, AssetPerson, QQueryProperty> {
  QueryBuilder<AssetPerson, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }
}
