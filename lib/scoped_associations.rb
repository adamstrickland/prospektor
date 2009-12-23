module ActiveRecord
  class Reflection::AssociationReflection
    # Return a named scope instead of the bare ActiveRecord::Base subclass.
    def klass_with_scope
      k = klass_without_scope
      options[:scope].nil? ? k : k.send(options[:scope])
    end
    alias_method_chain :klass, :scope
  end

  module Associations
    class AssociationProxy
      def raise_on_type_mismatch(record)
        # Flipping these predicates avoids passing a named scope (instance of Scope) to #is_a?, which expects a class such as an ActiveRecord::Base
        # subclass, and raising an exception.
        unless record.is_a?(@reflection.class_name.constantize) || record.is_a?(@reflection.klass)
          message = "#{@reflection.class_name}(##{@reflection.klass.object_id}) expected, got #{record.class}(##{record.class.object_id})"
          raise ActiveRecord::AssociationTypeMismatch, message
        end
      end
    end

    class HasManyThroughAssociation
      # The basic through option results in an INNER JOIN whose conditions simple manage PK/FK relationships and the simple polymorphic *_type
      # columns.  We augment those join conditions with the conditions represented by the through association's scope.  Ideally, AR::Base would
      # be refactored to allow #add_conditions! to NOT prepend the SQL WHERE keyword and we could get the scoped conditions *automatically*
      # from @reflection.through_reflection.klass.add_conditions!  Note that this solution relies, most appropriately, on the association
      # reflection's #klass method returning a named scope (see above).
      def construct_joins_with_through_scope(custom_joins = nil)
        if scope_conditions = @reflection.through_reflection.klass.send(:scope, :find, :conditions) # More natural than testing @reflection.through_reflection.options[:scope] 
          scoped_join_conditions = @reflection.through_reflection.klass.sanitize_sql(scope_conditions)
          custom_joins = "AND #{scoped_join_conditions} #{custom_joins}" if scoped_join_conditions
        end
        construct_joins_without_through_scope(custom_joins)
      end
      alias_method_chain :construct_joins, :through_scope
    end
  end
end

ActiveRecord::Base.valid_keys_for_has_many_association << :scope
ActiveRecord::Base.valid_keys_for_has_one_association << :scope
ActiveRecord::Base.valid_keys_for_belongs_to_association << :scope
ActiveRecord::Base.valid_keys_for_has_and_belongs_to_many_association << :scope