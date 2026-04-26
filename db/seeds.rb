# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
# #   end
# <div class="relative size-32 bg-gray-50 rounded-3xl border-2 border-dashed border-gray-200 flex flex-col items-center justify-center cursor-pointer hover:border-blue-400 hover:bg-white transition-all group" 
#                       onclick="document.getElementById('gallery-input').click()">
                    
#                     <%# حقل رفع الملفات مع ID ثابت مطابق للـ onclick %>
#                     <%= f.file_field :images, 
#                           id: "gallery-input", 
#                           multiple: true, 
#                           accept: "image/*",
#                           class: "hidden",
#                           onchange: "handleMultipleImages(this, 'gallery-grid')" %>

#                     <div class="flex flex-col items-center gap-2 text-gray-400 group-hover:text-blue-500">
#                       <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="size-6">
#                         <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
#                       </svg>
#                       <span class="text-[10px] font-black uppercase">Add Images</span>
#                     </div>
#                   </div>