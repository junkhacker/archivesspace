require 'spec_helper'
require 'securerandom'

describe 'DigitalObjectComponent model' do

  it "Allows digital object components to be created" do
    doc = create(:json_digital_object_component_unpub_ancestor)
    bib_note = build(:json_note_bibliography)
    do_note = build(:json_note_digital_object)
    doc.notes = [bib_note, do_note]
    DigitalObjectComponent[doc.id].title.should eq(doc.title)
  end


  it "creates an ARK identifier with archival object" do
    doc = create(:json_digital_object_component)

    doc_row = DigitalObjectComponent.first

    expect(ARKIdentifier.first(:digital_object_component_id => doc_row[:id])).to_not be_nil
    
    doc.delete
  end

  it "deletes ARK Identifier when resource is deleted" do
    doc = create(:json_digital_object_component)

    doc_row = DigitalObjectComponent.first

    expect(ARKIdentifier.first(:digital_object_component_id => doc_row[:id])).to_not be_nil

    doc.delete

    expect(ARKIdentifier.first(:digital_object_component_id => doc_row[:id])).to be_nil
  end


end
