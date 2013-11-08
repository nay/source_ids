require "source_ids/version"

module SourceIds
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def accepts_source_ids_for(source_association_name, options = {})
      source_association = reflect_on_association(source_association_name)
      raise "Could not find association #{source_association_name}" unless source_association
      relation = source_association.through_reflection
      raise "#{source_association_name} does not have :through" unless relation
      source_name = source_association.source_reflection.name
      fk_in_relation = source_association.source_reflection.foreign_key
      source_ids_name = options[:as] || "#{source_association_name.to_s.singularize}_ids"

      # _source_ids=
      define_method "_#{source_ids_name}=" do |ids|
        ids = ids.find_all(&:present?) # care for hidden field of collection_select

        # mark destruction if not included in ids
        send(relation.name).each do |r|
          source_id = r.send(fk_in_relation)
          r.mark_for_destruction unless ids.include?(source_id)
        end

        ids.each do |source_id|
          unless send(relation.name).detect{|r| r.send(fk_in_relation) == source_id}
            send(relation.name).build(fk_in_relation => source_id)
          end
        end

        send(relation.name).target.sort do |a, b|
          if a.marked_for_destruction? && b.marked_for_destruction?
            0
          elsif a.marked_for_destruction?
            -1
          elsif b.marked_for_destruction?
            1
          else
            ids.index(a.send(fk_in_relation)) <=> ids.index(b.send(fk_in_relation))
          end
        end
      end

      # _source_ids
      define_method "_#{source_ids_name}" do
        send(relation.name).find_all{|r| !r.marked_for_destruction?}.map(&fk_in_relation.to_sym)
      end

      # _sources
      define_method "_#{source_association_name}" do
        send(relation.name).find_all{|r| !r.marked_for_destruction?}.map(&source_name)
      end
    end
  end
end

ActiveRecord::Base.send(:include, SourceIds)
