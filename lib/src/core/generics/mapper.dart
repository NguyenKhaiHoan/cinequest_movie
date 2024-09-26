/// Base chung cho các mapper
abstract class Mapper<D, E> {
  ///
  E dtoToEntity(D dto);

  ///
  D entityToDto(E entity);
}
