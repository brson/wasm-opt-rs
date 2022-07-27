(module
  (type (;0;) (func (param i32 i32)))
  (type (;1;) (func (param i32 i32 i32) (result i32)))
  (type (;2;) (func (param i32 i32) (result i32)))
  (type (;3;) (func (param i32)))
  (type (;4;) (func (param i32) (result i32)))
  (type (;5;) (func))
  (type (;6;) (func (param i32 i32 i32)))
  (type (;7;) (func (param i32 i32 i32 i32) (result i32)))
  (type (;8;) (func (result i32)))
  (type (;9;) (func (param i32) (result i64)))
  (type (;10;) (func (param i32 i32 i32 i32)))
  (type (;11;) (func (param i32 i32 i32 i32 i32)))
  (type (;12;) (func (param i32 i32 i32 i32 i32) (result i32)))
  (type (;13;) (func (param i32 i32 i32 i32 i32 i32) (result i32)))
  (type (;14;) (func (param i64 i32 i32) (result i32)))
  (import "__wbindgen_placeholder__" "__wbindgen_describe" (func $_ZN12wasm_bindgen19__wbindgen_describe17h343cf312c5d90ee6E (type 3)))
  (import "__wbindgen_placeholder__" "__wbg_alert_f30b78c50df83b2d" (func $_ZN11hello_world5alert28__wbg_alert_f30b78c50df83b2d17he1e4a4b8d8d0ea44E (type 0)))
  (import "__wbindgen_externref_xform__" "__wbindgen_externref_table_grow" (func $_ZN12wasm_bindgen9externref31__wbindgen_externref_table_grow17ha4f746c989afa1c2E (type 4)))
  (import "__wbindgen_externref_xform__" "__wbindgen_externref_table_set_null" (func $_ZN12wasm_bindgen9externref35__wbindgen_externref_table_set_null17h958e92ab89f726f8E (type 3)))
  (func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h764538e45c6cfe1eE (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    local.get 1
    call $_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h90ba1b7a9eb08159E)
  (func $__wbindgen_describe___wbg_alert_f30b78c50df83b2d (type 5)
    call $_ZN12wasm_bindgen4__rt19link_mem_intrinsics17hdfca264069c2a983E
    i32.const 11
    call $_ZN12wasm_bindgen19__wbindgen_describe17h343cf312c5d90ee6E
    i32.const 0
    call $_ZN12wasm_bindgen19__wbindgen_describe17h343cf312c5d90ee6E
    i32.const 1
    call $_ZN12wasm_bindgen19__wbindgen_describe17h343cf312c5d90ee6E
    i32.const 15
    call $_ZN12wasm_bindgen19__wbindgen_describe17h343cf312c5d90ee6E
    call $_ZN60_$LT$str$u20$as$u20$wasm_bindgen..describe..WasmDescribe$GT$8describe17h75ce916392c06b84E
    call $_ZN65_$LT$$LP$$RP$$u20$as$u20$wasm_bindgen..describe..WasmDescribe$GT$8describe17h770faab4f3cdf7a3E
    call $_ZN65_$LT$$LP$$RP$$u20$as$u20$wasm_bindgen..describe..WasmDescribe$GT$8describe17h770faab4f3cdf7a3E)
  (func $greet (type 0) (param i32 i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 64
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    local.get 1
    i32.store offset=12
    local.get 2
    local.get 0
    i32.store offset=8
    local.get 2
    i32.const 1
    i32.store offset=36
    local.get 2
    local.get 2
    i32.const 8
    i32.add
    i32.store offset=32
    local.get 2
    i32.const 60
    i32.add
    i32.const 1
    i32.store
    local.get 2
    i64.const 2
    i64.store offset=44 align=4
    local.get 2
    i32.const 1048584
    i32.store offset=40
    local.get 2
    local.get 2
    i32.const 32
    i32.add
    i32.store offset=56
    local.get 2
    i32.const 16
    i32.add
    local.get 2
    i32.const 40
    i32.add
    call $_ZN5alloc3fmt6format12format_inner17hc76132f0eaf03496E
    local.get 2
    i32.load offset=16
    local.tee 3
    local.get 2
    i32.load offset=24
    call $_ZN11hello_world5alert28__wbg_alert_f30b78c50df83b2d17he1e4a4b8d8d0ea44E
    block  ;; label = @1
      local.get 2
      i32.load offset=20
      local.tee 4
      i32.const 1
      i32.lt_s
      br_if 0 (;@1;)
      local.get 3
      local.get 4
      i32.const 1
      call $__rust_dealloc
    end
    block  ;; label = @1
      local.get 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      i32.const 1
      call $__rust_dealloc
    end
    local.get 2
    i32.const 64
    i32.add
    global.set $__stack_pointer)
  (func $__rust_alloc (type 2) (param i32 i32) (result i32)
    (local i32)
    local.get 0
    local.get 1
    call $__rdl_alloc
    local.set 2
    local.get 2
    return)
  (func $__rust_dealloc (type 6) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $__rdl_dealloc
    return)
  (func $__rust_realloc (type 7) (param i32 i32 i32 i32) (result i32)
    (local i32)
    local.get 0
    local.get 1
    local.get 2
    local.get 3
    call $__rdl_realloc
    local.set 4
    local.get 4
    return)
  (func $__rust_alloc_error_handler (type 0) (param i32 i32)
    local.get 0
    local.get 1
    call $__rg_oom
    return)
  (func $_ZN12wasm_bindgen4__rt19link_mem_intrinsics17hdfca264069c2a983E (type 5)
    call $_ZN12wasm_bindgen9externref15link_intrinsics17h746d56ace27b8dbdE)
  (func $__wbindgen_exn_store (type 3) (param i32)
    i32.const 0
    local.get 0
    i32.store offset=1049348
    i32.const 0
    i32.const 1
    i32.store8 offset=1049344)
  (func $__wbindgen_malloc (type 4) (param i32) (result i32)
    block  ;; label = @1
      local.get 0
      i32.const 2147483644
      i32.gt_u
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 0
        br_if 0 (;@2;)
        i32.const 4
        return
      end
      local.get 0
      local.get 0
      i32.const 2147483645
      i32.lt_u
      i32.const 2
      i32.shl
      call $__rust_alloc
      local.tee 0
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      return
    end
    call $_ZN12wasm_bindgen4__rt14malloc_failure17hd9616718b81cbbb5E
    unreachable)
  (func $_ZN12wasm_bindgen4__rt14malloc_failure17hd9616718b81cbbb5E (type 5)
    call $_ZN3std7process5abort17hf7c8bef35d3938e7E
    unreachable)
  (func $__wbindgen_realloc (type 1) (param i32 i32 i32) (result i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.const 2147483644
        i32.gt_u
        br_if 0 (;@2;)
        local.get 0
        local.get 1
        i32.const 4
        local.get 2
        call $__rust_realloc
        local.tee 1
        br_if 1 (;@1;)
      end
      call $_ZN12wasm_bindgen4__rt14malloc_failure17hd9616718b81cbbb5E
      unreachable
    end
    local.get 1)
  (func $__wbindgen_free (type 0) (param i32 i32)
    block  ;; label = @1
      local.get 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      i32.const 4
      call $__rust_dealloc
    end)
  (func $_ZN65_$LT$$LP$$RP$$u20$as$u20$wasm_bindgen..describe..WasmDescribe$GT$8describe17h770faab4f3cdf7a3E (type 5)
    i32.const 26
    call $_ZN12wasm_bindgen19__wbindgen_describe17h343cf312c5d90ee6E)
  (func $_ZN60_$LT$str$u20$as$u20$wasm_bindgen..describe..WasmDescribe$GT$8describe17h75ce916392c06b84E (type 5)
    i32.const 14
    call $_ZN12wasm_bindgen19__wbindgen_describe17h343cf312c5d90ee6E)
  (func $_ZN12wasm_bindgen9externref14internal_error17h6e35a70b4a64eecaE (type 5)
    call $_ZN3std7process5abort17hf7c8bef35d3938e7E
    unreachable)
  (func $__externref_table_alloc (type 8) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        i32.const 0
        i32.load offset=1049352
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        i32.load offset=1049356
        local.set 0
        br 1 (;@1;)
      end
      i32.const 0
      i64.const 0
      i64.store offset=1049368 align=4
      i32.const 0
      i64.const 0
      i64.store offset=1049360 align=4
      i32.const 0
      i32.const 1
      i32.store offset=1049352
      i32.const 4
      local.set 0
    end
    i32.const 0
    i32.const 4
    i32.store offset=1049356
    i32.const 0
    i32.load offset=1049360
    local.set 1
    i32.const 0
    i32.load offset=1049364
    local.set 2
    i32.const 0
    i64.const 0
    i64.store offset=1049360 align=4
    i32.const 0
    i32.load offset=1049372
    local.set 3
    i32.const 0
    i32.load offset=1049368
    local.set 4
    i32.const 0
    i64.const 0
    i64.store offset=1049368 align=4
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 4
          local.get 2
          i32.eq
          br_if 0 (;@3;)
          local.get 2
          local.set 2
          local.get 1
          local.set 5
          local.get 0
          local.set 6
          br 1 (;@2;)
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            local.get 1
            i32.eq
            br_if 0 (;@4;)
            local.get 1
            local.set 5
            local.get 0
            local.set 6
            br 1 (;@3;)
          end
          local.get 1
          i32.const 128
          local.get 1
          i32.const 128
          i32.gt_u
          select
          local.tee 5
          call $_ZN12wasm_bindgen9externref31__wbindgen_externref_table_grow17ha4f746c989afa1c2E
          local.tee 6
          i32.const -1
          i32.eq
          br_if 2 (;@1;)
          block  ;; label = @4
            block  ;; label = @5
              local.get 3
              br_if 0 (;@5;)
              local.get 6
              local.set 3
              br 1 (;@4;)
            end
            local.get 3
            local.get 1
            i32.add
            local.get 6
            i32.ne
            br_if 3 (;@1;)
          end
          local.get 5
          local.get 1
          i32.add
          local.tee 5
          i32.const 2
          i32.shl
          local.tee 6
          i32.const 2147483644
          i32.gt_u
          br_if 2 (;@1;)
          local.get 6
          i32.const 4
          call $__rust_alloc
          local.tee 6
          i32.eqz
          br_if 2 (;@1;)
          local.get 6
          local.get 0
          local.get 1
          i32.const 2
          i32.shl
          local.tee 7
          call $memcpy
          drop
          local.get 1
          i32.eqz
          br_if 0 (;@3;)
          local.get 1
          i32.const 1073741823
          i32.and
          local.get 1
          i32.ne
          br_if 0 (;@3;)
          local.get 7
          i32.const -2147483645
          i32.add
          i32.const -2147483644
          i32.lt_u
          br_if 0 (;@3;)
          local.get 0
          local.get 7
          i32.const 4
          call $__rust_dealloc
        end
        local.get 2
        local.get 5
        i32.ge_u
        br_if 1 (;@1;)
        local.get 6
        local.get 2
        i32.const 2
        i32.shl
        i32.add
        local.get 2
        i32.const 1
        i32.add
        local.tee 2
        i32.store
      end
      local.get 4
      local.get 2
      i32.ge_u
      br_if 0 (;@1;)
      local.get 6
      i32.eqz
      br_if 0 (;@1;)
      local.get 6
      local.get 4
      i32.const 2
      i32.shl
      i32.add
      i32.load
      local.set 1
      i32.const 0
      local.get 3
      i32.store offset=1049372
      i32.const 0
      local.get 1
      i32.store offset=1049368
      i32.const 0
      local.get 2
      i32.store offset=1049364
      i32.const 0
      i32.load offset=1049360
      local.set 2
      i32.const 0
      local.get 5
      i32.store offset=1049360
      i32.const 0
      i32.load offset=1049356
      local.set 1
      i32.const 0
      local.get 6
      i32.store offset=1049356
      block  ;; label = @2
        local.get 2
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        i32.const 1073741823
        i32.and
        local.get 2
        i32.ne
        br_if 0 (;@2;)
        local.get 2
        i32.const 2
        i32.shl
        local.tee 6
        i32.const -2147483645
        i32.add
        i32.const -2147483644
        i32.lt_u
        br_if 0 (;@2;)
        local.get 1
        local.get 6
        i32.const 4
        call $__rust_dealloc
      end
      local.get 3
      local.get 4
      i32.add
      return
    end
    call $_ZN12wasm_bindgen9externref14internal_error17h6e35a70b4a64eecaE
    unreachable)
  (func $__externref_table_dealloc (type 3) (param i32)
    (local i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 36
        i32.lt_u
        br_if 0 (;@2;)
        local.get 0
        call $_ZN12wasm_bindgen9externref35__wbindgen_externref_table_set_null17h958e92ab89f726f8E
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load offset=1049352
            i32.eqz
            br_if 0 (;@4;)
            i32.const 0
            i32.load offset=1049356
            local.set 1
            br 1 (;@3;)
          end
          i32.const 0
          i64.const 0
          i64.store offset=1049368 align=4
          i32.const 0
          i64.const 0
          i64.store offset=1049360 align=4
          i32.const 0
          i32.const 1
          i32.store offset=1049352
          i32.const 4
          local.set 1
        end
        i32.const 0
        i32.const 4
        i32.store offset=1049356
        i32.const 0
        i32.load offset=1049364
        local.set 2
        i32.const 0
        i32.load offset=1049360
        local.set 3
        i32.const 0
        i64.const 0
        i64.store offset=1049360 align=4
        i32.const 0
        i32.load offset=1049368
        local.set 4
        i32.const 0
        i32.load offset=1049372
        local.set 5
        i32.const 0
        i64.const 0
        i64.store offset=1049368 align=4
        local.get 5
        local.get 0
        i32.gt_u
        br_if 1 (;@1;)
        local.get 0
        local.get 5
        i32.sub
        local.tee 0
        local.get 2
        i32.ge_u
        br_if 1 (;@1;)
        local.get 1
        i32.eqz
        br_if 1 (;@1;)
        local.get 1
        local.get 0
        i32.const 2
        i32.shl
        i32.add
        local.get 4
        i32.store
        i32.const 0
        local.get 5
        i32.store offset=1049372
        i32.const 0
        local.get 0
        i32.store offset=1049368
        i32.const 0
        local.get 2
        i32.store offset=1049364
        i32.const 0
        i32.load offset=1049360
        local.set 0
        i32.const 0
        local.get 3
        i32.store offset=1049360
        i32.const 0
        i32.load offset=1049356
        local.set 5
        i32.const 0
        local.get 1
        i32.store offset=1049356
        local.get 0
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        i32.const 1073741823
        i32.and
        local.get 0
        i32.ne
        br_if 0 (;@2;)
        local.get 0
        i32.const 2
        i32.shl
        local.tee 0
        i32.const -2147483645
        i32.add
        i32.const -2147483644
        i32.lt_u
        br_if 0 (;@2;)
        local.get 5
        local.get 0
        i32.const 4
        call $__rust_dealloc
      end
      return
    end
    call $_ZN12wasm_bindgen9externref14internal_error17h6e35a70b4a64eecaE
    unreachable)
  (func $__externref_drop_slice (type 0) (param i32 i32)
    block  ;; label = @1
      local.get 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      i32.const 2
      i32.shl
      local.set 1
      loop  ;; label = @2
        local.get 0
        i32.load
        call $__externref_table_dealloc
        local.get 0
        i32.const 4
        i32.add
        local.set 0
        local.get 1
        i32.const -4
        i32.add
        local.tee 1
        br_if 0 (;@2;)
      end
    end)
  (func $__externref_heap_live_count (type 8) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        i32.const 0
        i32.load offset=1049352
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        i32.load offset=1049356
        local.set 0
        br 1 (;@1;)
      end
      i32.const 0
      i64.const 0
      i64.store offset=1049368 align=4
      i32.const 0
      i64.const 0
      i64.store offset=1049360 align=4
      i32.const 0
      i32.const 1
      i32.store offset=1049352
      i32.const 4
      local.set 0
    end
    i32.const 0
    i32.const 4
    i32.store offset=1049356
    i32.const 0
    i32.load offset=1049360
    local.set 1
    i32.const 0
    i32.load offset=1049364
    local.set 2
    i32.const 0
    i64.const 0
    i64.store offset=1049360 align=4
    i32.const 0
    i32.load offset=1049372
    local.set 3
    i32.const 0
    i32.load offset=1049368
    local.set 4
    i32.const 0
    i64.const 0
    i64.store offset=1049368 align=4
    i32.const 0
    local.set 5
    block  ;; label = @1
      block  ;; label = @2
        local.get 4
        local.get 2
        i32.ge_u
        br_if 0 (;@2;)
        local.get 0
        i32.eqz
        br_if 1 (;@1;)
        i32.const 0
        local.set 5
        local.get 4
        local.set 6
        loop  ;; label = @3
          local.get 6
          local.get 2
          i32.ge_u
          br_if 2 (;@1;)
          local.get 5
          i32.const 1
          i32.add
          local.set 5
          local.get 0
          local.get 6
          i32.const 2
          i32.shl
          i32.add
          i32.load
          local.tee 6
          local.get 2
          i32.lt_u
          br_if 0 (;@3;)
        end
      end
      i32.const 0
      local.get 3
      i32.store offset=1049372
      i32.const 0
      local.get 4
      i32.store offset=1049368
      i32.const 0
      local.get 2
      i32.store offset=1049364
      i32.const 0
      local.get 0
      i32.store offset=1049356
      i32.const 0
      i32.load offset=1049360
      local.set 6
      i32.const 0
      local.get 1
      i32.store offset=1049360
      block  ;; label = @2
        local.get 6
        i32.eqz
        br_if 0 (;@2;)
        local.get 6
        i32.const 1073741823
        i32.and
        local.get 6
        i32.ne
        br_if 0 (;@2;)
        local.get 6
        i32.const 2
        i32.shl
        local.tee 6
        i32.const -2147483645
        i32.add
        i32.const -2147483644
        i32.lt_u
        br_if 0 (;@2;)
        i32.const 4
        local.get 6
        i32.const 4
        call $__rust_dealloc
      end
      local.get 2
      local.get 5
      i32.sub
      return
    end
    call $_ZN12wasm_bindgen9externref14internal_error17h6e35a70b4a64eecaE
    unreachable)
  (func $_ZN12wasm_bindgen9externref15link_intrinsics17h746d56ace27b8dbdE (type 5))
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h6fa6cd067880123dE (type 9) (param i32) (result i64)
    i64.const -594079794615694393)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17he101e458b14bb15cE (type 9) (param i32) (result i64)
    i64.const -5139102199292759541)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h31489a6526c1f165E (type 6) (param i32 i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        local.get 2
        i32.add
        local.tee 2
        local.get 1
        i32.lt_u
        br_if 0 (;@2;)
        local.get 0
        i32.const 4
        i32.add
        i32.load
        local.tee 1
        i32.const 1
        i32.shl
        local.tee 4
        local.get 2
        local.get 4
        local.get 2
        i32.gt_u
        select
        local.tee 2
        i32.const 8
        local.get 2
        i32.const 8
        i32.gt_u
        select
        local.tee 2
        i32.const -1
        i32.xor
        i32.const 31
        i32.shr_u
        local.set 4
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            br_if 0 (;@4;)
            i32.const 0
            local.set 1
            br 1 (;@3;)
          end
          local.get 3
          local.get 0
          i32.load
          i32.store offset=16
          local.get 3
          local.get 1
          i32.store offset=20
          local.get 1
          i32.const -1
          i32.xor
          i32.const 31
          i32.shr_u
          local.set 1
        end
        local.get 3
        local.get 1
        i32.store offset=24
        local.get 3
        local.get 2
        local.get 4
        local.get 3
        i32.const 16
        i32.add
        call $_ZN5alloc7raw_vec11finish_grow17h527bc9005c9fb91fE
        local.get 3
        i32.load offset=4
        local.set 1
        block  ;; label = @3
          local.get 3
          i32.load
          br_if 0 (;@3;)
          local.get 0
          local.get 1
          i32.store
          local.get 0
          i32.const 4
          i32.add
          local.get 2
          i32.store
          br 2 (;@1;)
        end
        local.get 3
        i32.const 8
        i32.add
        i32.load
        local.tee 0
        i32.const -2147483647
        i32.eq
        br_if 1 (;@1;)
        local.get 0
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        local.get 0
        call $_ZN5alloc5alloc18handle_alloc_error17h42b2ac242981c6baE
        unreachable
      end
      call $_ZN5alloc7raw_vec17capacity_overflow17he8831a0490d21b13E
      unreachable
    end
    local.get 3
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN4core3ptr100drop_in_place$LT$$RF$mut$u20$std..io..Write..write_fmt..Adapter$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$17h0499f59298030c64E (type 3) (param i32))
  (func $_ZN4core3ptr226drop_in_place$LT$std..error..$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$std..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$..from..StringError$GT$17h1ef7a4997c9d0324E (type 3) (param i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.const 4
      i32.add
      i32.load
      local.tee 1
      i32.const 1
      i32.lt_s
      br_if 0 (;@1;)
      local.get 0
      i32.load
      local.get 1
      local.get 1
      i32.const -1
      i32.xor
      i32.const 31
      i32.shr_u
      call $__rust_dealloc
    end)
  (func $_ZN4core3ptr70drop_in_place$LT$std..panicking..begin_panic_handler..PanicPayload$GT$17h5d1b3c05875cdf66E (type 3) (param i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load offset=4
      local.tee 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i32.const 8
      i32.add
      i32.load
      local.tee 0
      i32.const 1
      i32.lt_s
      br_if 0 (;@1;)
      local.get 1
      local.get 0
      local.get 0
      i32.const -1
      i32.xor
      i32.const 31
      i32.shr_u
      call $__rust_dealloc
    end)
  (func $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hadb22ebda269801aE (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    call $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17h3d6dd539f6b3fa04E
    drop
    i32.const 0)
  (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17h3d6dd539f6b3fa04E (type 2) (param i32 i32) (result i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.const 128
            i32.lt_u
            br_if 0 (;@4;)
            local.get 2
            i32.const 0
            i32.store offset=12
            local.get 1
            i32.const 2048
            i32.ge_u
            br_if 1 (;@3;)
            local.get 2
            local.get 1
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=13
            local.get 2
            local.get 1
            i32.const 6
            i32.shr_u
            i32.const 192
            i32.or
            i32.store8 offset=12
            i32.const 2
            local.set 1
            br 2 (;@2;)
          end
          block  ;; label = @4
            local.get 0
            i32.load offset=8
            local.tee 3
            local.get 0
            i32.load offset=4
            i32.ne
            br_if 0 (;@4;)
            local.get 0
            local.get 3
            call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17h246a17ec59bd1223E
            local.get 0
            i32.load offset=8
            local.set 3
          end
          local.get 0
          local.get 3
          i32.const 1
          i32.add
          i32.store offset=8
          local.get 0
          i32.load
          local.get 3
          i32.add
          local.get 1
          i32.store8
          br 2 (;@1;)
        end
        block  ;; label = @3
          local.get 1
          i32.const 65536
          i32.lt_u
          br_if 0 (;@3;)
          local.get 2
          local.get 1
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=15
          local.get 2
          local.get 1
          i32.const 6
          i32.shr_u
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=14
          local.get 2
          local.get 1
          i32.const 12
          i32.shr_u
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=13
          local.get 2
          local.get 1
          i32.const 18
          i32.shr_u
          i32.const 7
          i32.and
          i32.const 240
          i32.or
          i32.store8 offset=12
          i32.const 4
          local.set 1
          br 1 (;@2;)
        end
        local.get 2
        local.get 1
        i32.const 63
        i32.and
        i32.const 128
        i32.or
        i32.store8 offset=14
        local.get 2
        local.get 1
        i32.const 12
        i32.shr_u
        i32.const 224
        i32.or
        i32.store8 offset=12
        local.get 2
        local.get 1
        i32.const 6
        i32.shr_u
        i32.const 63
        i32.and
        i32.const 128
        i32.or
        i32.store8 offset=13
        i32.const 3
        local.set 1
      end
      block  ;; label = @2
        local.get 0
        i32.const 4
        i32.add
        i32.load
        local.get 0
        i32.load offset=8
        local.tee 3
        i32.sub
        local.get 1
        i32.ge_u
        br_if 0 (;@2;)
        local.get 0
        local.get 3
        local.get 1
        call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h31489a6526c1f165E
        local.get 0
        i32.load offset=8
        local.set 3
      end
      local.get 0
      i32.load
      local.get 3
      i32.add
      local.get 2
      i32.const 12
      i32.add
      local.get 1
      call $memcpy
      drop
      local.get 0
      local.get 3
      local.get 1
      i32.add
      i32.store offset=8
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    i32.const 0)
  (func $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17hd159acdabb295994E (type 2) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    local.get 0
    i32.load
    i32.store offset=4
    local.get 2
    i32.const 8
    i32.add
    i32.const 16
    i32.add
    local.get 1
    i32.const 16
    i32.add
    i64.load align=4
    i64.store
    local.get 2
    i32.const 8
    i32.add
    i32.const 8
    i32.add
    local.get 1
    i32.const 8
    i32.add
    i64.load align=4
    i64.store
    local.get 2
    local.get 1
    i64.load align=4
    i64.store offset=8
    local.get 2
    i32.const 4
    i32.add
    i32.const 1048600
    local.get 2
    i32.const 8
    i32.add
    call $_ZN4core3fmt5write17h62b20074abd80558E
    local.set 1
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17h7325a891291bec2fE (type 1) (param i32 i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 0
      i32.const 4
      i32.add
      i32.load
      local.get 0
      i32.load offset=8
      local.tee 3
      i32.sub
      local.get 2
      i32.ge_u
      br_if 0 (;@1;)
      local.get 0
      local.get 3
      local.get 2
      call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17h31489a6526c1f165E
      local.get 0
      i32.load offset=8
      local.set 3
    end
    local.get 0
    i32.load
    local.get 3
    i32.add
    local.get 1
    local.get 2
    call $memcpy
    drop
    local.get 0
    local.get 3
    local.get 2
    i32.add
    i32.store offset=8
    i32.const 0)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17h246a17ec59bd1223E (type 0) (param i32 i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.const 1
        i32.add
        local.tee 3
        local.get 1
        i32.lt_u
        br_if 0 (;@2;)
        local.get 0
        i32.const 4
        i32.add
        i32.load
        local.tee 1
        i32.const 1
        i32.shl
        local.tee 4
        local.get 3
        local.get 4
        local.get 3
        i32.gt_u
        select
        local.tee 3
        i32.const 8
        local.get 3
        i32.const 8
        i32.gt_u
        select
        local.tee 3
        i32.const -1
        i32.xor
        i32.const 31
        i32.shr_u
        local.set 4
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            br_if 0 (;@4;)
            i32.const 0
            local.set 1
            br 1 (;@3;)
          end
          local.get 2
          local.get 0
          i32.load
          i32.store offset=16
          local.get 2
          local.get 1
          i32.store offset=20
          local.get 1
          i32.const -1
          i32.xor
          i32.const 31
          i32.shr_u
          local.set 1
        end
        local.get 2
        local.get 1
        i32.store offset=24
        local.get 2
        local.get 3
        local.get 4
        local.get 2
        i32.const 16
        i32.add
        call $_ZN5alloc7raw_vec11finish_grow17h527bc9005c9fb91fE
        local.get 2
        i32.load offset=4
        local.set 1
        block  ;; label = @3
          local.get 2
          i32.load
          br_if 0 (;@3;)
          local.get 0
          local.get 1
          i32.store
          local.get 0
          i32.const 4
          i32.add
          local.get 3
          i32.store
          br 2 (;@1;)
        end
        local.get 2
        i32.const 8
        i32.add
        i32.load
        local.tee 0
        i32.const -2147483647
        i32.eq
        br_if 1 (;@1;)
        local.get 0
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        local.get 0
        call $_ZN5alloc5alloc18handle_alloc_error17h42b2ac242981c6baE
        unreachable
      end
      call $_ZN5alloc7raw_vec17capacity_overflow17he8831a0490d21b13E
      unreachable
    end
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN5alloc7raw_vec11finish_grow17h527bc9005c9fb91fE (type 10) (param i32 i32 i32 i32)
    (local i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 2
                  i32.eqz
                  br_if 0 (;@7;)
                  i32.const 1
                  local.set 4
                  local.get 1
                  i32.const 0
                  i32.lt_s
                  br_if 1 (;@6;)
                  local.get 3
                  i32.load offset=8
                  i32.eqz
                  br_if 3 (;@4;)
                  local.get 3
                  i32.load offset=4
                  local.tee 5
                  br_if 2 (;@5;)
                  local.get 1
                  br_if 4 (;@3;)
                  local.get 2
                  local.set 3
                  br 5 (;@2;)
                end
                local.get 0
                local.get 1
                i32.store offset=4
                i32.const 1
                local.set 4
              end
              i32.const 0
              local.set 1
              br 4 (;@1;)
            end
            local.get 3
            i32.load
            local.get 5
            local.get 2
            local.get 1
            call $__rust_realloc
            local.set 3
            br 2 (;@2;)
          end
          local.get 1
          br_if 0 (;@3;)
          local.get 2
          local.set 3
          br 1 (;@2;)
        end
        local.get 1
        local.get 2
        call $__rust_alloc
        local.set 3
      end
      block  ;; label = @2
        local.get 3
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        local.get 3
        i32.store offset=4
        i32.const 0
        local.set 4
        br 1 (;@1;)
      end
      local.get 0
      local.get 1
      i32.store offset=4
      local.get 2
      local.set 1
    end
    local.get 0
    local.get 4
    i32.store
    local.get 0
    i32.const 8
    i32.add
    local.get 1
    i32.store)
  (func $_ZN8dlmalloc17Dlmalloc$LT$A$GT$6malloc17he4572c35964f8c9bE (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 1
              i32.const 9
              i32.lt_u
              br_if 0 (;@5;)
              i32.const 16
              i32.const 8
              call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
              local.get 1
              i32.gt_u
              br_if 1 (;@4;)
              br 2 (;@3;)
            end
            local.get 0
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h1bd11c33484481a4E
            local.set 2
            br 2 (;@2;)
          end
          i32.const 16
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          local.set 1
        end
        call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h3a01fed98ec6278aE
        local.set 3
        i32.const 0
        local.set 2
        local.get 3
        local.get 3
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
        i32.const 20
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
        i32.add
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
        i32.add
        i32.sub
        i32.const -65544
        i32.add
        i32.const -9
        i32.and
        i32.const -3
        i32.add
        local.tee 3
        i32.const 0
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
        i32.const 2
        i32.shl
        i32.sub
        local.tee 4
        local.get 4
        local.get 3
        i32.gt_u
        select
        local.get 1
        i32.sub
        local.get 0
        i32.le_u
        br_if 0 (;@2;)
        local.get 1
        i32.const 16
        local.get 0
        i32.const 4
        i32.add
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
        i32.const -5
        i32.add
        local.get 0
        i32.gt_u
        select
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
        local.tee 4
        i32.add
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
        i32.add
        i32.const -4
        i32.add
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h1bd11c33484481a4E
        local.tee 3
        i32.eqz
        br_if 0 (;@2;)
        local.get 3
        call $_ZN8dlmalloc8dlmalloc5Chunk8from_mem17h3404f9b5c5e6d4a5E
        local.set 0
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.const -1
            i32.add
            local.tee 2
            local.get 3
            i32.and
            br_if 0 (;@4;)
            local.get 0
            local.set 1
            br 1 (;@3;)
          end
          local.get 2
          local.get 3
          i32.add
          i32.const 0
          local.get 1
          i32.sub
          i32.and
          call $_ZN8dlmalloc8dlmalloc5Chunk8from_mem17h3404f9b5c5e6d4a5E
          local.set 2
          i32.const 16
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          local.set 3
          local.get 0
          call $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E
          local.get 2
          i32.const 0
          local.get 1
          local.get 2
          local.get 0
          i32.sub
          local.get 3
          i32.gt_u
          select
          i32.add
          local.tee 1
          local.get 0
          i32.sub
          local.tee 2
          i32.sub
          local.set 3
          block  ;; label = @4
            local.get 0
            call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h56605450e209003dE
            br_if 0 (;@4;)
            local.get 1
            local.get 3
            call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17hc493611b2d4f74f1E
            local.get 0
            local.get 2
            call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17hc493611b2d4f74f1E
            local.get 0
            local.get 2
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17h04ab92064f11ad31E
            br 1 (;@3;)
          end
          local.get 0
          i32.load
          local.set 0
          local.get 1
          local.get 3
          i32.store offset=4
          local.get 1
          local.get 0
          local.get 2
          i32.add
          i32.store
        end
        local.get 1
        call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h56605450e209003dE
        br_if 1 (;@1;)
        local.get 1
        call $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E
        local.tee 0
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
        local.get 4
        i32.add
        i32.le_u
        br_if 1 (;@1;)
        local.get 1
        local.get 4
        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
        local.set 2
        local.get 1
        local.get 4
        call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17hc493611b2d4f74f1E
        local.get 2
        local.get 0
        local.get 4
        i32.sub
        local.tee 0
        call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17hc493611b2d4f74f1E
        local.get 2
        local.get 0
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17h04ab92064f11ad31E
        br 1 (;@1;)
      end
      local.get 2
      return
    end
    local.get 1
    call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
    local.set 0
    local.get 1
    call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h56605450e209003dE
    drop
    local.get 0)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h1bd11c33484481a4E (type 4) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 0
                  i32.const 245
                  i32.lt_u
                  br_if 0 (;@7;)
                  call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h3a01fed98ec6278aE
                  local.set 2
                  i32.const 0
                  local.set 3
                  local.get 2
                  local.get 2
                  i32.const 8
                  call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                  i32.const 20
                  i32.const 8
                  call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                  i32.add
                  i32.const 16
                  i32.const 8
                  call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                  i32.add
                  i32.sub
                  i32.const -65544
                  i32.add
                  i32.const -9
                  i32.and
                  i32.const -3
                  i32.add
                  local.tee 2
                  i32.const 0
                  i32.const 16
                  i32.const 8
                  call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                  i32.const 2
                  i32.shl
                  i32.sub
                  local.tee 4
                  local.get 4
                  local.get 2
                  i32.gt_u
                  select
                  local.get 0
                  i32.le_u
                  br_if 6 (;@1;)
                  local.get 0
                  i32.const 4
                  i32.add
                  i32.const 8
                  call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                  local.set 2
                  i32.const 0
                  i32.load offset=1049400
                  i32.eqz
                  br_if 5 (;@2;)
                  i32.const 0
                  local.set 5
                  block  ;; label = @8
                    local.get 2
                    i32.const 256
                    i32.lt_u
                    br_if 0 (;@8;)
                    i32.const 31
                    local.set 5
                    local.get 2
                    i32.const 16777215
                    i32.gt_u
                    br_if 0 (;@8;)
                    local.get 2
                    i32.const 6
                    local.get 2
                    i32.const 8
                    i32.shr_u
                    i32.clz
                    local.tee 0
                    i32.sub
                    i32.shr_u
                    i32.const 1
                    i32.and
                    local.get 0
                    i32.const 1
                    i32.shl
                    i32.sub
                    i32.const 62
                    i32.add
                    local.set 5
                  end
                  i32.const 0
                  local.get 2
                  i32.sub
                  local.set 3
                  local.get 5
                  i32.const 2
                  i32.shl
                  i32.const 1049668
                  i32.add
                  i32.load
                  local.tee 4
                  br_if 1 (;@6;)
                  i32.const 0
                  local.set 0
                  i32.const 0
                  local.set 6
                  br 2 (;@5;)
                end
                i32.const 16
                local.get 0
                i32.const 4
                i32.add
                i32.const 16
                i32.const 8
                call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                i32.const -5
                i32.add
                local.get 0
                i32.gt_u
                select
                i32.const 8
                call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                local.set 2
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              i32.const 0
                              i32.load offset=1049396
                              local.tee 6
                              local.get 2
                              i32.const 3
                              i32.shr_u
                              local.tee 3
                              i32.shr_u
                              local.tee 0
                              i32.const 3
                              i32.and
                              br_if 0 (;@13;)
                              local.get 2
                              i32.const 0
                              i32.load offset=1049796
                              i32.le_u
                              br_if 11 (;@2;)
                              local.get 0
                              br_if 1 (;@12;)
                              i32.const 0
                              i32.load offset=1049400
                              local.tee 0
                              i32.eqz
                              br_if 11 (;@2;)
                              local.get 0
                              call $_ZN8dlmalloc8dlmalloc9least_bit17hc868b6f46985b42bE
                              i32.ctz
                              i32.const 2
                              i32.shl
                              i32.const 1049668
                              i32.add
                              i32.load
                              local.tee 4
                              call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h593cb0bc6379ebafE
                              call $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E
                              local.get 2
                              i32.sub
                              local.set 3
                              block  ;; label = @14
                                local.get 4
                                call $_ZN8dlmalloc8dlmalloc9TreeChunk14leftmost_child17h98469de652a23deaE
                                local.tee 0
                                i32.eqz
                                br_if 0 (;@14;)
                                loop  ;; label = @15
                                  local.get 0
                                  call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h593cb0bc6379ebafE
                                  call $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E
                                  local.get 2
                                  i32.sub
                                  local.tee 6
                                  local.get 3
                                  local.get 6
                                  local.get 3
                                  i32.lt_u
                                  local.tee 6
                                  select
                                  local.set 3
                                  local.get 0
                                  local.get 4
                                  local.get 6
                                  select
                                  local.set 4
                                  local.get 0
                                  call $_ZN8dlmalloc8dlmalloc9TreeChunk14leftmost_child17h98469de652a23deaE
                                  local.tee 0
                                  br_if 0 (;@15;)
                                end
                              end
                              local.get 4
                              call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h593cb0bc6379ebafE
                              local.tee 0
                              local.get 2
                              call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                              local.set 6
                              i32.const 1049396
                              local.get 4
                              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h2484774ef561a518E
                              local.get 3
                              i32.const 16
                              i32.const 8
                              call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                              i32.lt_u
                              br_if 5 (;@8;)
                              local.get 6
                              call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h593cb0bc6379ebafE
                              local.set 6
                              local.get 0
                              local.get 2
                              call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h0f4b537b8fccf023E
                              local.get 6
                              local.get 3
                              call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17h74d4897d77859f14E
                              i32.const 0
                              i32.load offset=1049796
                              local.tee 4
                              i32.eqz
                              br_if 4 (;@9;)
                              local.get 4
                              i32.const 3
                              i32.shr_u
                              local.tee 7
                              i32.const 3
                              i32.shl
                              i32.const 1049404
                              i32.add
                              local.set 8
                              i32.const 0
                              i32.load offset=1049804
                              local.set 4
                              i32.const 0
                              i32.load offset=1049396
                              local.tee 5
                              i32.const 1
                              local.get 7
                              i32.shl
                              local.tee 7
                              i32.and
                              i32.eqz
                              br_if 2 (;@11;)
                              local.get 8
                              i32.load offset=8
                              local.set 7
                              br 3 (;@10;)
                            end
                            block  ;; label = @13
                              block  ;; label = @14
                                local.get 0
                                i32.const -1
                                i32.xor
                                i32.const 1
                                i32.and
                                local.get 3
                                i32.add
                                local.tee 2
                                i32.const 3
                                i32.shl
                                local.tee 4
                                i32.const 1049412
                                i32.add
                                i32.load
                                local.tee 0
                                i32.const 8
                                i32.add
                                i32.load
                                local.tee 3
                                local.get 4
                                i32.const 1049404
                                i32.add
                                local.tee 4
                                i32.eq
                                br_if 0 (;@14;)
                                local.get 3
                                local.get 4
                                i32.store offset=12
                                local.get 4
                                local.get 3
                                i32.store offset=8
                                br 1 (;@13;)
                              end
                              i32.const 0
                              local.get 6
                              i32.const -2
                              local.get 2
                              i32.rotl
                              i32.and
                              i32.store offset=1049396
                            end
                            local.get 0
                            local.get 2
                            i32.const 3
                            i32.shl
                            call $_ZN8dlmalloc8dlmalloc5Chunk20set_inuse_and_pinuse17ha76eb13dcd83db20E
                            local.get 0
                            call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
                            local.set 3
                            br 11 (;@1;)
                          end
                          block  ;; label = @12
                            block  ;; label = @13
                              i32.const 1
                              local.get 3
                              i32.const 31
                              i32.and
                              local.tee 3
                              i32.shl
                              call $_ZN8dlmalloc8dlmalloc9left_bits17hd43e75bebd2d32bdE
                              local.get 0
                              local.get 3
                              i32.shl
                              i32.and
                              call $_ZN8dlmalloc8dlmalloc9least_bit17hc868b6f46985b42bE
                              i32.ctz
                              local.tee 3
                              i32.const 3
                              i32.shl
                              local.tee 6
                              i32.const 1049412
                              i32.add
                              i32.load
                              local.tee 0
                              i32.const 8
                              i32.add
                              i32.load
                              local.tee 4
                              local.get 6
                              i32.const 1049404
                              i32.add
                              local.tee 6
                              i32.eq
                              br_if 0 (;@13;)
                              local.get 4
                              local.get 6
                              i32.store offset=12
                              local.get 6
                              local.get 4
                              i32.store offset=8
                              br 1 (;@12;)
                            end
                            i32.const 0
                            i32.const 0
                            i32.load offset=1049396
                            i32.const -2
                            local.get 3
                            i32.rotl
                            i32.and
                            i32.store offset=1049396
                          end
                          local.get 0
                          local.get 2
                          call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h0f4b537b8fccf023E
                          local.get 0
                          local.get 2
                          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                          local.tee 4
                          local.get 3
                          i32.const 3
                          i32.shl
                          local.get 2
                          i32.sub
                          local.tee 6
                          call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17h74d4897d77859f14E
                          block  ;; label = @12
                            i32.const 0
                            i32.load offset=1049796
                            local.tee 2
                            i32.eqz
                            br_if 0 (;@12;)
                            local.get 2
                            i32.const 3
                            i32.shr_u
                            local.tee 8
                            i32.const 3
                            i32.shl
                            i32.const 1049404
                            i32.add
                            local.set 3
                            i32.const 0
                            i32.load offset=1049804
                            local.set 2
                            block  ;; label = @13
                              block  ;; label = @14
                                i32.const 0
                                i32.load offset=1049396
                                local.tee 7
                                i32.const 1
                                local.get 8
                                i32.shl
                                local.tee 8
                                i32.and
                                i32.eqz
                                br_if 0 (;@14;)
                                local.get 3
                                i32.load offset=8
                                local.set 8
                                br 1 (;@13;)
                              end
                              i32.const 0
                              local.get 7
                              local.get 8
                              i32.or
                              i32.store offset=1049396
                              local.get 3
                              local.set 8
                            end
                            local.get 3
                            local.get 2
                            i32.store offset=8
                            local.get 8
                            local.get 2
                            i32.store offset=12
                            local.get 2
                            local.get 3
                            i32.store offset=12
                            local.get 2
                            local.get 8
                            i32.store offset=8
                          end
                          i32.const 0
                          local.get 4
                          i32.store offset=1049804
                          i32.const 0
                          local.get 6
                          i32.store offset=1049796
                          local.get 0
                          call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
                          local.set 3
                          br 10 (;@1;)
                        end
                        i32.const 0
                        local.get 5
                        local.get 7
                        i32.or
                        i32.store offset=1049396
                        local.get 8
                        local.set 7
                      end
                      local.get 8
                      local.get 4
                      i32.store offset=8
                      local.get 7
                      local.get 4
                      i32.store offset=12
                      local.get 4
                      local.get 8
                      i32.store offset=12
                      local.get 4
                      local.get 7
                      i32.store offset=8
                    end
                    i32.const 0
                    local.get 6
                    i32.store offset=1049804
                    i32.const 0
                    local.get 3
                    i32.store offset=1049796
                    br 1 (;@7;)
                  end
                  local.get 0
                  local.get 3
                  local.get 2
                  i32.add
                  call $_ZN8dlmalloc8dlmalloc5Chunk20set_inuse_and_pinuse17ha76eb13dcd83db20E
                end
                local.get 0
                call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
                local.tee 3
                br_if 5 (;@1;)
                br 4 (;@2;)
              end
              local.get 2
              local.get 5
              call $_ZN8dlmalloc8dlmalloc24leftshift_for_tree_index17hd789c537cab28411E
              i32.shl
              local.set 8
              i32.const 0
              local.set 0
              i32.const 0
              local.set 6
              loop  ;; label = @6
                block  ;; label = @7
                  local.get 4
                  call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h593cb0bc6379ebafE
                  call $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E
                  local.tee 7
                  local.get 2
                  i32.lt_u
                  br_if 0 (;@7;)
                  local.get 7
                  local.get 2
                  i32.sub
                  local.tee 7
                  local.get 3
                  i32.ge_u
                  br_if 0 (;@7;)
                  local.get 7
                  local.set 3
                  local.get 4
                  local.set 6
                  local.get 7
                  br_if 0 (;@7;)
                  i32.const 0
                  local.set 3
                  local.get 4
                  local.set 6
                  local.get 4
                  local.set 0
                  br 3 (;@4;)
                end
                local.get 4
                i32.const 20
                i32.add
                i32.load
                local.tee 7
                local.get 0
                local.get 7
                local.get 4
                local.get 8
                i32.const 29
                i32.shr_u
                i32.const 4
                i32.and
                i32.add
                i32.const 16
                i32.add
                i32.load
                local.tee 4
                i32.ne
                select
                local.get 0
                local.get 7
                select
                local.set 0
                local.get 8
                i32.const 1
                i32.shl
                local.set 8
                local.get 4
                br_if 0 (;@6;)
              end
            end
            block  ;; label = @5
              local.get 0
              local.get 6
              i32.or
              br_if 0 (;@5;)
              i32.const 0
              local.set 6
              i32.const 1
              local.get 5
              i32.shl
              call $_ZN8dlmalloc8dlmalloc9left_bits17hd43e75bebd2d32bdE
              i32.const 0
              i32.load offset=1049400
              i32.and
              local.tee 0
              i32.eqz
              br_if 3 (;@2;)
              local.get 0
              call $_ZN8dlmalloc8dlmalloc9least_bit17hc868b6f46985b42bE
              i32.ctz
              i32.const 2
              i32.shl
              i32.const 1049668
              i32.add
              i32.load
              local.set 0
            end
            local.get 0
            i32.eqz
            br_if 1 (;@3;)
          end
          loop  ;; label = @4
            local.get 0
            local.get 6
            local.get 0
            call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h593cb0bc6379ebafE
            call $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E
            local.tee 4
            local.get 2
            i32.ge_u
            local.get 4
            local.get 2
            i32.sub
            local.tee 4
            local.get 3
            i32.lt_u
            i32.and
            local.tee 8
            select
            local.set 6
            local.get 4
            local.get 3
            local.get 8
            select
            local.set 3
            local.get 0
            call $_ZN8dlmalloc8dlmalloc9TreeChunk14leftmost_child17h98469de652a23deaE
            local.tee 0
            br_if 0 (;@4;)
          end
        end
        local.get 6
        i32.eqz
        br_if 0 (;@2;)
        block  ;; label = @3
          i32.const 0
          i32.load offset=1049796
          local.tee 0
          local.get 2
          i32.lt_u
          br_if 0 (;@3;)
          local.get 3
          local.get 0
          local.get 2
          i32.sub
          i32.ge_u
          br_if 1 (;@2;)
        end
        local.get 6
        call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h593cb0bc6379ebafE
        local.tee 0
        local.get 2
        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
        local.set 4
        i32.const 1049396
        local.get 6
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h2484774ef561a518E
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            i32.const 16
            i32.const 8
            call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
            i32.lt_u
            br_if 0 (;@4;)
            local.get 0
            local.get 2
            call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h0f4b537b8fccf023E
            local.get 4
            local.get 3
            call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17h74d4897d77859f14E
            block  ;; label = @5
              local.get 3
              i32.const 256
              i32.lt_u
              br_if 0 (;@5;)
              i32.const 1049396
              local.get 4
              local.get 3
              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17habc5b0b62eef023bE
              br 2 (;@3;)
            end
            local.get 3
            i32.const 3
            i32.shr_u
            local.tee 6
            i32.const 3
            i32.shl
            i32.const 1049404
            i32.add
            local.set 3
            block  ;; label = @5
              block  ;; label = @6
                i32.const 0
                i32.load offset=1049396
                local.tee 8
                i32.const 1
                local.get 6
                i32.shl
                local.tee 6
                i32.and
                i32.eqz
                br_if 0 (;@6;)
                local.get 3
                i32.load offset=8
                local.set 6
                br 1 (;@5;)
              end
              i32.const 0
              local.get 8
              local.get 6
              i32.or
              i32.store offset=1049396
              local.get 3
              local.set 6
            end
            local.get 3
            local.get 4
            i32.store offset=8
            local.get 6
            local.get 4
            i32.store offset=12
            local.get 4
            local.get 3
            i32.store offset=12
            local.get 4
            local.get 6
            i32.store offset=8
            br 1 (;@3;)
          end
          local.get 0
          local.get 3
          local.get 2
          i32.add
          call $_ZN8dlmalloc8dlmalloc5Chunk20set_inuse_and_pinuse17ha76eb13dcd83db20E
        end
        local.get 0
        call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
        local.tee 3
        br_if 1 (;@1;)
      end
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        i32.const 0
                        i32.load offset=1049796
                        local.tee 3
                        local.get 2
                        i32.ge_u
                        br_if 0 (;@10;)
                        i32.const 0
                        i32.load offset=1049800
                        local.tee 0
                        local.get 2
                        i32.gt_u
                        br_if 2 (;@8;)
                        local.get 1
                        i32.const 1049396
                        local.get 2
                        call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h3a01fed98ec6278aE
                        local.tee 0
                        i32.sub
                        local.get 0
                        i32.const 8
                        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                        i32.add
                        i32.const 20
                        i32.const 8
                        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                        i32.add
                        i32.const 16
                        i32.const 8
                        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                        i32.add
                        i32.const 8
                        i32.add
                        i32.const 65536
                        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                        call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$5alloc17he1272ca423b0b1b4E
                        local.get 1
                        i32.load
                        local.tee 3
                        br_if 1 (;@9;)
                        i32.const 0
                        local.set 3
                        br 9 (;@1;)
                      end
                      i32.const 0
                      i32.load offset=1049804
                      local.set 0
                      block  ;; label = @10
                        local.get 3
                        local.get 2
                        i32.sub
                        local.tee 3
                        i32.const 16
                        i32.const 8
                        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                        i32.ge_u
                        br_if 0 (;@10;)
                        i32.const 0
                        i32.const 0
                        i32.store offset=1049804
                        i32.const 0
                        i32.load offset=1049796
                        local.set 2
                        i32.const 0
                        i32.const 0
                        i32.store offset=1049796
                        local.get 0
                        local.get 2
                        call $_ZN8dlmalloc8dlmalloc5Chunk20set_inuse_and_pinuse17ha76eb13dcd83db20E
                        local.get 0
                        call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
                        local.set 3
                        br 9 (;@1;)
                      end
                      local.get 0
                      local.get 2
                      call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                      local.set 4
                      i32.const 0
                      local.get 3
                      i32.store offset=1049796
                      i32.const 0
                      local.get 4
                      i32.store offset=1049804
                      local.get 4
                      local.get 3
                      call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17h74d4897d77859f14E
                      local.get 0
                      local.get 2
                      call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h0f4b537b8fccf023E
                      local.get 0
                      call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
                      local.set 3
                      br 8 (;@1;)
                    end
                    local.get 1
                    i32.load offset=8
                    local.set 5
                    i32.const 0
                    i32.const 0
                    i32.load offset=1049812
                    local.get 1
                    i32.load offset=4
                    local.tee 8
                    i32.add
                    local.tee 0
                    i32.store offset=1049812
                    i32.const 0
                    i32.const 0
                    i32.load offset=1049816
                    local.tee 4
                    local.get 0
                    local.get 4
                    local.get 0
                    i32.gt_u
                    select
                    i32.store offset=1049816
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          i32.const 0
                          i32.load offset=1049808
                          i32.eqz
                          br_if 0 (;@11;)
                          i32.const 1049820
                          local.set 0
                          loop  ;; label = @12
                            local.get 3
                            local.get 0
                            call $_ZN8dlmalloc8dlmalloc7Segment3top17he89977119f2095b0E
                            i32.eq
                            br_if 2 (;@10;)
                            local.get 0
                            i32.load offset=8
                            local.tee 0
                            br_if 0 (;@12;)
                            br 3 (;@9;)
                          end
                        end
                        i32.const 0
                        i32.load offset=1049840
                        local.tee 0
                        i32.eqz
                        br_if 3 (;@7;)
                        local.get 3
                        local.get 0
                        i32.lt_u
                        br_if 3 (;@7;)
                        br 7 (;@3;)
                      end
                      local.get 0
                      call $_ZN8dlmalloc8dlmalloc7Segment9is_extern17h775061e2c0d47378E
                      br_if 0 (;@9;)
                      local.get 0
                      call $_ZN8dlmalloc8dlmalloc7Segment9sys_flags17h6d168430a1d92f9aE
                      local.get 5
                      i32.ne
                      br_if 0 (;@9;)
                      local.get 0
                      i32.const 0
                      i32.load offset=1049808
                      call $_ZN8dlmalloc8dlmalloc7Segment5holds17h276a4b63e2947208E
                      br_if 3 (;@6;)
                    end
                    i32.const 0
                    i32.const 0
                    i32.load offset=1049840
                    local.tee 0
                    local.get 3
                    local.get 3
                    local.get 0
                    i32.gt_u
                    select
                    i32.store offset=1049840
                    local.get 3
                    local.get 8
                    i32.add
                    local.set 4
                    i32.const 1049820
                    local.set 0
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          loop  ;; label = @12
                            local.get 0
                            i32.load
                            local.get 4
                            i32.eq
                            br_if 1 (;@11;)
                            local.get 0
                            i32.load offset=8
                            local.tee 0
                            br_if 0 (;@12;)
                            br 2 (;@10;)
                          end
                        end
                        local.get 0
                        call $_ZN8dlmalloc8dlmalloc7Segment9is_extern17h775061e2c0d47378E
                        br_if 0 (;@10;)
                        local.get 0
                        call $_ZN8dlmalloc8dlmalloc7Segment9sys_flags17h6d168430a1d92f9aE
                        local.get 5
                        i32.eq
                        br_if 1 (;@9;)
                      end
                      i32.const 0
                      i32.load offset=1049808
                      local.set 4
                      i32.const 1049820
                      local.set 0
                      block  ;; label = @10
                        loop  ;; label = @11
                          block  ;; label = @12
                            local.get 0
                            i32.load
                            local.get 4
                            i32.gt_u
                            br_if 0 (;@12;)
                            local.get 0
                            call $_ZN8dlmalloc8dlmalloc7Segment3top17he89977119f2095b0E
                            local.get 4
                            i32.gt_u
                            br_if 2 (;@10;)
                          end
                          local.get 0
                          i32.load offset=8
                          local.tee 0
                          br_if 0 (;@11;)
                        end
                        i32.const 0
                        local.set 0
                      end
                      local.get 0
                      call $_ZN8dlmalloc8dlmalloc7Segment3top17he89977119f2095b0E
                      local.tee 6
                      i32.const 20
                      i32.const 8
                      call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                      local.tee 9
                      i32.sub
                      i32.const -23
                      i32.add
                      local.set 0
                      local.get 4
                      local.get 0
                      local.get 0
                      call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
                      local.tee 7
                      i32.const 8
                      call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                      local.get 7
                      i32.sub
                      i32.add
                      local.tee 0
                      local.get 0
                      local.get 4
                      i32.const 16
                      i32.const 8
                      call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                      i32.add
                      i32.lt_u
                      select
                      local.tee 7
                      call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
                      local.set 10
                      local.get 7
                      local.get 9
                      call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                      local.set 0
                      call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h3a01fed98ec6278aE
                      local.tee 11
                      i32.const 8
                      call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                      local.set 12
                      i32.const 20
                      i32.const 8
                      call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                      local.set 13
                      i32.const 16
                      i32.const 8
                      call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                      local.set 14
                      i32.const 0
                      local.get 3
                      local.get 3
                      call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
                      local.tee 15
                      i32.const 8
                      call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                      local.get 15
                      i32.sub
                      local.tee 16
                      call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                      local.tee 15
                      i32.store offset=1049808
                      i32.const 0
                      local.get 11
                      local.get 8
                      i32.add
                      local.get 14
                      local.get 12
                      local.get 13
                      i32.add
                      i32.add
                      local.get 16
                      i32.add
                      i32.sub
                      local.tee 11
                      i32.store offset=1049800
                      local.get 15
                      local.get 11
                      i32.const 1
                      i32.or
                      i32.store offset=4
                      call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h3a01fed98ec6278aE
                      local.tee 12
                      i32.const 8
                      call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                      local.set 13
                      i32.const 20
                      i32.const 8
                      call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                      local.set 14
                      i32.const 16
                      i32.const 8
                      call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                      local.set 16
                      local.get 15
                      local.get 11
                      call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                      local.set 15
                      i32.const 0
                      i32.const 2097152
                      i32.store offset=1049836
                      local.get 15
                      local.get 16
                      local.get 14
                      local.get 13
                      local.get 12
                      i32.sub
                      i32.add
                      i32.add
                      i32.store offset=4
                      local.get 7
                      local.get 9
                      call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h0f4b537b8fccf023E
                      i32.const 0
                      i64.load offset=1049820 align=4
                      local.set 17
                      local.get 10
                      i32.const 8
                      i32.add
                      i32.const 0
                      i64.load offset=1049828 align=4
                      i64.store align=4
                      local.get 10
                      local.get 17
                      i64.store align=4
                      i32.const 0
                      local.get 5
                      i32.store offset=1049832
                      i32.const 0
                      local.get 8
                      i32.store offset=1049824
                      i32.const 0
                      local.get 3
                      i32.store offset=1049820
                      i32.const 0
                      local.get 10
                      i32.store offset=1049828
                      loop  ;; label = @10
                        local.get 0
                        i32.const 4
                        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                        local.set 3
                        local.get 0
                        call $_ZN8dlmalloc8dlmalloc5Chunk14fencepost_head17h32cfaa035be31489E
                        i32.store offset=4
                        local.get 3
                        local.set 0
                        local.get 6
                        local.get 3
                        i32.const 4
                        i32.add
                        i32.gt_u
                        br_if 0 (;@10;)
                      end
                      local.get 7
                      local.get 4
                      i32.eq
                      br_if 7 (;@2;)
                      local.get 7
                      local.get 4
                      i32.sub
                      local.set 0
                      local.get 4
                      local.get 0
                      local.get 4
                      local.get 0
                      call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                      call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h9991ae3d78ae1397E
                      block  ;; label = @10
                        local.get 0
                        i32.const 256
                        i32.lt_u
                        br_if 0 (;@10;)
                        i32.const 1049396
                        local.get 4
                        local.get 0
                        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17habc5b0b62eef023bE
                        br 8 (;@2;)
                      end
                      local.get 0
                      i32.const 3
                      i32.shr_u
                      local.tee 3
                      i32.const 3
                      i32.shl
                      i32.const 1049404
                      i32.add
                      local.set 0
                      block  ;; label = @10
                        block  ;; label = @11
                          i32.const 0
                          i32.load offset=1049396
                          local.tee 6
                          i32.const 1
                          local.get 3
                          i32.shl
                          local.tee 3
                          i32.and
                          i32.eqz
                          br_if 0 (;@11;)
                          local.get 0
                          i32.load offset=8
                          local.set 3
                          br 1 (;@10;)
                        end
                        i32.const 0
                        local.get 6
                        local.get 3
                        i32.or
                        i32.store offset=1049396
                        local.get 0
                        local.set 3
                      end
                      local.get 0
                      local.get 4
                      i32.store offset=8
                      local.get 3
                      local.get 4
                      i32.store offset=12
                      local.get 4
                      local.get 0
                      i32.store offset=12
                      local.get 4
                      local.get 3
                      i32.store offset=8
                      br 7 (;@2;)
                    end
                    local.get 0
                    i32.load
                    local.set 6
                    local.get 0
                    local.get 3
                    i32.store
                    local.get 0
                    local.get 0
                    i32.load offset=4
                    local.get 8
                    i32.add
                    i32.store offset=4
                    local.get 3
                    call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
                    local.tee 0
                    i32.const 8
                    call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                    local.set 4
                    local.get 6
                    call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
                    local.tee 8
                    i32.const 8
                    call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                    local.set 7
                    local.get 3
                    local.get 4
                    local.get 0
                    i32.sub
                    i32.add
                    local.tee 3
                    local.get 2
                    call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                    local.set 4
                    local.get 3
                    local.get 2
                    call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h0f4b537b8fccf023E
                    local.get 6
                    local.get 7
                    local.get 8
                    i32.sub
                    i32.add
                    local.tee 0
                    local.get 2
                    local.get 3
                    i32.add
                    i32.sub
                    local.set 2
                    block  ;; label = @9
                      i32.const 0
                      i32.load offset=1049808
                      local.get 0
                      i32.eq
                      br_if 0 (;@9;)
                      i32.const 0
                      i32.load offset=1049804
                      local.get 0
                      i32.eq
                      br_if 4 (;@5;)
                      local.get 0
                      call $_ZN8dlmalloc8dlmalloc5Chunk5inuse17h4d9d8a6e39f8aee5E
                      br_if 5 (;@4;)
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 0
                          call $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E
                          local.tee 6
                          i32.const 256
                          i32.lt_u
                          br_if 0 (;@11;)
                          i32.const 1049396
                          local.get 0
                          call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h2484774ef561a518E
                          br 1 (;@10;)
                        end
                        block  ;; label = @11
                          local.get 0
                          i32.const 12
                          i32.add
                          i32.load
                          local.tee 8
                          local.get 0
                          i32.const 8
                          i32.add
                          i32.load
                          local.tee 7
                          i32.eq
                          br_if 0 (;@11;)
                          local.get 7
                          local.get 8
                          i32.store offset=12
                          local.get 8
                          local.get 7
                          i32.store offset=8
                          br 1 (;@10;)
                        end
                        i32.const 0
                        i32.const 0
                        i32.load offset=1049396
                        i32.const -2
                        local.get 6
                        i32.const 3
                        i32.shr_u
                        i32.rotl
                        i32.and
                        i32.store offset=1049396
                      end
                      local.get 6
                      local.get 2
                      i32.add
                      local.set 2
                      local.get 0
                      local.get 6
                      call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                      local.set 0
                      br 5 (;@4;)
                    end
                    i32.const 0
                    local.get 4
                    i32.store offset=1049808
                    i32.const 0
                    i32.const 0
                    i32.load offset=1049800
                    local.get 2
                    i32.add
                    local.tee 0
                    i32.store offset=1049800
                    local.get 4
                    local.get 0
                    i32.const 1
                    i32.or
                    i32.store offset=4
                    local.get 3
                    call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
                    local.set 3
                    br 7 (;@1;)
                  end
                  i32.const 0
                  local.get 0
                  local.get 2
                  i32.sub
                  local.tee 3
                  i32.store offset=1049800
                  i32.const 0
                  i32.const 0
                  i32.load offset=1049808
                  local.tee 0
                  local.get 2
                  call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                  local.tee 4
                  i32.store offset=1049808
                  local.get 4
                  local.get 3
                  i32.const 1
                  i32.or
                  i32.store offset=4
                  local.get 0
                  local.get 2
                  call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h0f4b537b8fccf023E
                  local.get 0
                  call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
                  local.set 3
                  br 6 (;@1;)
                end
                i32.const 0
                local.get 3
                i32.store offset=1049840
                br 3 (;@3;)
              end
              local.get 0
              local.get 0
              i32.load offset=4
              local.get 8
              i32.add
              i32.store offset=4
              i32.const 1049396
              i32.const 0
              i32.load offset=1049808
              i32.const 0
              i32.load offset=1049800
              local.get 8
              i32.add
              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8init_top17h9ba4d179485fee16E
              br 3 (;@2;)
            end
            i32.const 0
            local.get 4
            i32.store offset=1049804
            i32.const 0
            i32.const 0
            i32.load offset=1049796
            local.get 2
            i32.add
            local.tee 0
            i32.store offset=1049796
            local.get 4
            local.get 0
            call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17h74d4897d77859f14E
            local.get 3
            call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
            local.set 3
            br 3 (;@1;)
          end
          local.get 4
          local.get 2
          local.get 0
          call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h9991ae3d78ae1397E
          block  ;; label = @4
            local.get 2
            i32.const 256
            i32.lt_u
            br_if 0 (;@4;)
            i32.const 1049396
            local.get 4
            local.get 2
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17habc5b0b62eef023bE
            local.get 3
            call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
            local.set 3
            br 3 (;@1;)
          end
          local.get 2
          i32.const 3
          i32.shr_u
          local.tee 2
          i32.const 3
          i32.shl
          i32.const 1049404
          i32.add
          local.set 0
          block  ;; label = @4
            block  ;; label = @5
              i32.const 0
              i32.load offset=1049396
              local.tee 6
              i32.const 1
              local.get 2
              i32.shl
              local.tee 2
              i32.and
              i32.eqz
              br_if 0 (;@5;)
              local.get 0
              i32.load offset=8
              local.set 2
              br 1 (;@4;)
            end
            i32.const 0
            local.get 6
            local.get 2
            i32.or
            i32.store offset=1049396
            local.get 0
            local.set 2
          end
          local.get 0
          local.get 4
          i32.store offset=8
          local.get 2
          local.get 4
          i32.store offset=12
          local.get 4
          local.get 0
          i32.store offset=12
          local.get 4
          local.get 2
          i32.store offset=8
          local.get 3
          call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
          local.set 3
          br 2 (;@1;)
        end
        i32.const 0
        i32.const 4095
        i32.store offset=1049844
        i32.const 0
        local.get 5
        i32.store offset=1049832
        i32.const 0
        local.get 8
        i32.store offset=1049824
        i32.const 0
        local.get 3
        i32.store offset=1049820
        i32.const 0
        i32.const 1049404
        i32.store offset=1049416
        i32.const 0
        i32.const 1049412
        i32.store offset=1049424
        i32.const 0
        i32.const 1049404
        i32.store offset=1049412
        i32.const 0
        i32.const 1049420
        i32.store offset=1049432
        i32.const 0
        i32.const 1049412
        i32.store offset=1049420
        i32.const 0
        i32.const 1049428
        i32.store offset=1049440
        i32.const 0
        i32.const 1049420
        i32.store offset=1049428
        i32.const 0
        i32.const 1049436
        i32.store offset=1049448
        i32.const 0
        i32.const 1049428
        i32.store offset=1049436
        i32.const 0
        i32.const 1049444
        i32.store offset=1049456
        i32.const 0
        i32.const 1049436
        i32.store offset=1049444
        i32.const 0
        i32.const 1049452
        i32.store offset=1049464
        i32.const 0
        i32.const 1049444
        i32.store offset=1049452
        i32.const 0
        i32.const 1049460
        i32.store offset=1049472
        i32.const 0
        i32.const 1049452
        i32.store offset=1049460
        i32.const 0
        i32.const 1049468
        i32.store offset=1049480
        i32.const 0
        i32.const 1049460
        i32.store offset=1049468
        i32.const 0
        i32.const 1049468
        i32.store offset=1049476
        i32.const 0
        i32.const 1049476
        i32.store offset=1049488
        i32.const 0
        i32.const 1049476
        i32.store offset=1049484
        i32.const 0
        i32.const 1049484
        i32.store offset=1049496
        i32.const 0
        i32.const 1049484
        i32.store offset=1049492
        i32.const 0
        i32.const 1049492
        i32.store offset=1049504
        i32.const 0
        i32.const 1049492
        i32.store offset=1049500
        i32.const 0
        i32.const 1049500
        i32.store offset=1049512
        i32.const 0
        i32.const 1049500
        i32.store offset=1049508
        i32.const 0
        i32.const 1049508
        i32.store offset=1049520
        i32.const 0
        i32.const 1049508
        i32.store offset=1049516
        i32.const 0
        i32.const 1049516
        i32.store offset=1049528
        i32.const 0
        i32.const 1049516
        i32.store offset=1049524
        i32.const 0
        i32.const 1049524
        i32.store offset=1049536
        i32.const 0
        i32.const 1049524
        i32.store offset=1049532
        i32.const 0
        i32.const 1049532
        i32.store offset=1049544
        i32.const 0
        i32.const 1049540
        i32.store offset=1049552
        i32.const 0
        i32.const 1049532
        i32.store offset=1049540
        i32.const 0
        i32.const 1049548
        i32.store offset=1049560
        i32.const 0
        i32.const 1049540
        i32.store offset=1049548
        i32.const 0
        i32.const 1049556
        i32.store offset=1049568
        i32.const 0
        i32.const 1049548
        i32.store offset=1049556
        i32.const 0
        i32.const 1049564
        i32.store offset=1049576
        i32.const 0
        i32.const 1049556
        i32.store offset=1049564
        i32.const 0
        i32.const 1049572
        i32.store offset=1049584
        i32.const 0
        i32.const 1049564
        i32.store offset=1049572
        i32.const 0
        i32.const 1049580
        i32.store offset=1049592
        i32.const 0
        i32.const 1049572
        i32.store offset=1049580
        i32.const 0
        i32.const 1049588
        i32.store offset=1049600
        i32.const 0
        i32.const 1049580
        i32.store offset=1049588
        i32.const 0
        i32.const 1049596
        i32.store offset=1049608
        i32.const 0
        i32.const 1049588
        i32.store offset=1049596
        i32.const 0
        i32.const 1049604
        i32.store offset=1049616
        i32.const 0
        i32.const 1049596
        i32.store offset=1049604
        i32.const 0
        i32.const 1049612
        i32.store offset=1049624
        i32.const 0
        i32.const 1049604
        i32.store offset=1049612
        i32.const 0
        i32.const 1049620
        i32.store offset=1049632
        i32.const 0
        i32.const 1049612
        i32.store offset=1049620
        i32.const 0
        i32.const 1049628
        i32.store offset=1049640
        i32.const 0
        i32.const 1049620
        i32.store offset=1049628
        i32.const 0
        i32.const 1049636
        i32.store offset=1049648
        i32.const 0
        i32.const 1049628
        i32.store offset=1049636
        i32.const 0
        i32.const 1049644
        i32.store offset=1049656
        i32.const 0
        i32.const 1049636
        i32.store offset=1049644
        i32.const 0
        i32.const 1049652
        i32.store offset=1049664
        i32.const 0
        i32.const 1049644
        i32.store offset=1049652
        i32.const 0
        i32.const 1049652
        i32.store offset=1049660
        call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h3a01fed98ec6278aE
        local.tee 4
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
        local.set 6
        i32.const 20
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
        local.set 7
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
        local.set 5
        i32.const 0
        local.get 3
        local.get 3
        call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
        local.tee 0
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
        local.get 0
        i32.sub
        local.tee 10
        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
        local.tee 0
        i32.store offset=1049808
        i32.const 0
        local.get 4
        local.get 8
        i32.add
        local.get 5
        local.get 6
        local.get 7
        i32.add
        i32.add
        local.get 10
        i32.add
        i32.sub
        local.tee 3
        i32.store offset=1049800
        local.get 0
        local.get 3
        i32.const 1
        i32.or
        i32.store offset=4
        call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h3a01fed98ec6278aE
        local.tee 4
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
        local.set 6
        i32.const 20
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
        local.set 8
        i32.const 16
        i32.const 8
        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
        local.set 7
        local.get 0
        local.get 3
        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
        local.set 0
        i32.const 0
        i32.const 2097152
        i32.store offset=1049836
        local.get 0
        local.get 7
        local.get 8
        local.get 6
        local.get 4
        i32.sub
        i32.add
        i32.add
        i32.store offset=4
      end
      i32.const 0
      local.set 3
      i32.const 0
      i32.load offset=1049800
      local.tee 0
      local.get 2
      i32.le_u
      br_if 0 (;@1;)
      i32.const 0
      local.get 0
      local.get 2
      i32.sub
      local.tee 3
      i32.store offset=1049800
      i32.const 0
      i32.const 0
      i32.load offset=1049808
      local.tee 0
      local.get 2
      call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
      local.tee 4
      i32.store offset=1049808
      local.get 4
      local.get 3
      i32.const 1
      i32.or
      i32.store offset=4
      local.get 0
      local.get 2
      call $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h0f4b537b8fccf023E
      local.get 0
      call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
      local.set 3
    end
    local.get 1
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 3)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17h04ab92064f11ad31E (type 0) (param i32 i32)
    (local i32 i32 i32 i32)
    local.get 0
    local.get 1
    call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          call $_ZN8dlmalloc8dlmalloc5Chunk6pinuse17h89f5f80c1a4cb95aE
          br_if 0 (;@3;)
          local.get 0
          i32.load
          local.set 3
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h56605450e209003dE
              br_if 0 (;@5;)
              local.get 3
              local.get 1
              i32.add
              local.set 1
              local.get 0
              local.get 3
              call $_ZN8dlmalloc8dlmalloc5Chunk12minus_offset17h39dd10694c91288eE
              local.tee 0
              i32.const 0
              i32.load offset=1049804
              i32.ne
              br_if 1 (;@4;)
              local.get 2
              i32.load offset=4
              i32.const 3
              i32.and
              i32.const 3
              i32.ne
              br_if 2 (;@3;)
              i32.const 0
              local.get 1
              i32.store offset=1049796
              local.get 0
              local.get 1
              local.get 2
              call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h9991ae3d78ae1397E
              return
            end
            i32.const 1049396
            local.get 0
            local.get 3
            i32.sub
            local.get 3
            local.get 1
            i32.add
            i32.const 16
            i32.add
            local.tee 0
            call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$4free17hc004ad78b71528d6E
            i32.eqz
            br_if 2 (;@2;)
            i32.const 0
            i32.const 0
            i32.load offset=1049812
            local.get 0
            i32.sub
            i32.store offset=1049812
            return
          end
          block  ;; label = @4
            local.get 3
            i32.const 256
            i32.lt_u
            br_if 0 (;@4;)
            i32.const 1049396
            local.get 0
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h2484774ef561a518E
            br 1 (;@3;)
          end
          block  ;; label = @4
            local.get 0
            i32.const 12
            i32.add
            i32.load
            local.tee 4
            local.get 0
            i32.const 8
            i32.add
            i32.load
            local.tee 5
            i32.eq
            br_if 0 (;@4;)
            local.get 5
            local.get 4
            i32.store offset=12
            local.get 4
            local.get 5
            i32.store offset=8
            br 1 (;@3;)
          end
          i32.const 0
          i32.const 0
          i32.load offset=1049396
          i32.const -2
          local.get 3
          i32.const 3
          i32.shr_u
          i32.rotl
          i32.and
          i32.store offset=1049396
        end
        block  ;; label = @3
          local.get 2
          call $_ZN8dlmalloc8dlmalloc5Chunk6cinuse17h59613f998488ffb3E
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 1
          local.get 2
          call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h9991ae3d78ae1397E
          br 2 (;@1;)
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.const 0
            i32.load offset=1049808
            i32.eq
            br_if 0 (;@4;)
            local.get 2
            i32.const 0
            i32.load offset=1049804
            i32.ne
            br_if 1 (;@3;)
            i32.const 0
            local.get 0
            i32.store offset=1049804
            i32.const 0
            i32.const 0
            i32.load offset=1049796
            local.get 1
            i32.add
            local.tee 1
            i32.store offset=1049796
            local.get 0
            local.get 1
            call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17h74d4897d77859f14E
            return
          end
          i32.const 0
          local.get 0
          i32.store offset=1049808
          i32.const 0
          i32.const 0
          i32.load offset=1049800
          local.get 1
          i32.add
          local.tee 1
          i32.store offset=1049800
          local.get 0
          local.get 1
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 0
          i32.const 0
          i32.load offset=1049804
          i32.ne
          br_if 1 (;@2;)
          i32.const 0
          i32.const 0
          i32.store offset=1049796
          i32.const 0
          i32.const 0
          i32.store offset=1049804
          return
        end
        local.get 2
        call $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E
        local.tee 3
        local.get 1
        i32.add
        local.set 1
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            i32.const 256
            i32.lt_u
            br_if 0 (;@4;)
            i32.const 1049396
            local.get 2
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h2484774ef561a518E
            br 1 (;@3;)
          end
          block  ;; label = @4
            local.get 2
            i32.const 12
            i32.add
            i32.load
            local.tee 4
            local.get 2
            i32.const 8
            i32.add
            i32.load
            local.tee 2
            i32.eq
            br_if 0 (;@4;)
            local.get 2
            local.get 4
            i32.store offset=12
            local.get 4
            local.get 2
            i32.store offset=8
            br 1 (;@3;)
          end
          i32.const 0
          i32.const 0
          i32.load offset=1049396
          i32.const -2
          local.get 3
          i32.const 3
          i32.shr_u
          i32.rotl
          i32.and
          i32.store offset=1049396
        end
        local.get 0
        local.get 1
        call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17h74d4897d77859f14E
        local.get 0
        i32.const 0
        i32.load offset=1049804
        i32.ne
        br_if 1 (;@1;)
        i32.const 0
        local.get 1
        i32.store offset=1049796
      end
      return
    end
    block  ;; label = @1
      local.get 1
      i32.const 256
      i32.lt_u
      br_if 0 (;@1;)
      i32.const 1049396
      local.get 0
      local.get 1
      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17habc5b0b62eef023bE
      return
    end
    local.get 1
    i32.const 3
    i32.shr_u
    local.tee 2
    i32.const 3
    i32.shl
    i32.const 1049404
    i32.add
    local.set 1
    block  ;; label = @1
      block  ;; label = @2
        i32.const 0
        i32.load offset=1049396
        local.tee 3
        i32.const 1
        local.get 2
        i32.shl
        local.tee 2
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        i32.load offset=8
        local.set 2
        br 1 (;@1;)
      end
      i32.const 0
      local.get 3
      local.get 2
      i32.or
      i32.store offset=1049396
      local.get 1
      local.set 2
    end
    local.get 1
    local.get 0
    i32.store offset=8
    local.get 2
    local.get 0
    i32.store offset=12
    local.get 0
    local.get 1
    i32.store offset=12
    local.get 0
    local.get 2
    i32.store offset=8)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h2484774ef561a518E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32)
    local.get 1
    i32.load offset=24
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          call $_ZN8dlmalloc8dlmalloc9TreeChunk4next17h656f2e3867c8acf8E
          local.get 1
          i32.ne
          br_if 0 (;@3;)
          local.get 1
          i32.const 20
          i32.const 16
          local.get 1
          i32.const 20
          i32.add
          local.tee 3
          i32.load
          local.tee 4
          select
          i32.add
          i32.load
          local.tee 5
          br_if 1 (;@2;)
          i32.const 0
          local.set 3
          br 2 (;@1;)
        end
        local.get 1
        call $_ZN8dlmalloc8dlmalloc9TreeChunk4prev17h527f673fd8318adbE
        local.tee 5
        local.get 1
        call $_ZN8dlmalloc8dlmalloc9TreeChunk4next17h656f2e3867c8acf8E
        local.tee 3
        call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h593cb0bc6379ebafE
        i32.store offset=12
        local.get 3
        local.get 5
        call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h593cb0bc6379ebafE
        i32.store offset=8
        br 1 (;@1;)
      end
      local.get 3
      local.get 1
      i32.const 16
      i32.add
      local.get 4
      select
      local.set 4
      loop  ;; label = @2
        local.get 4
        local.set 6
        local.get 5
        local.tee 3
        i32.const 20
        i32.add
        local.tee 5
        local.get 3
        i32.const 16
        i32.add
        local.get 5
        i32.load
        select
        local.tee 4
        i32.load
        local.tee 5
        br_if 0 (;@2;)
      end
      local.get 6
      i32.const 0
      i32.store
    end
    block  ;; label = @1
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          local.get 1
          i32.load offset=28
          local.tee 4
          i32.const 2
          i32.shl
          i32.add
          i32.const 272
          i32.add
          local.tee 5
          i32.load
          local.get 1
          i32.eq
          br_if 0 (;@3;)
          local.get 2
          i32.const 16
          i32.const 20
          local.get 2
          i32.load offset=16
          local.get 1
          i32.eq
          select
          i32.add
          local.get 3
          i32.store
          local.get 3
          br_if 1 (;@2;)
          br 2 (;@1;)
        end
        local.get 5
        local.get 3
        i32.store
        local.get 3
        br_if 0 (;@2;)
        local.get 0
        local.get 0
        i32.load offset=4
        i32.const -2
        local.get 4
        i32.rotl
        i32.and
        i32.store offset=4
        return
      end
      local.get 3
      local.get 2
      i32.store offset=24
      block  ;; label = @2
        local.get 1
        i32.load offset=16
        local.tee 5
        i32.eqz
        br_if 0 (;@2;)
        local.get 3
        local.get 5
        i32.store offset=16
        local.get 5
        local.get 3
        i32.store offset=24
      end
      local.get 1
      i32.const 20
      i32.add
      i32.load
      local.tee 5
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      i32.const 20
      i32.add
      local.get 5
      i32.store
      local.get 5
      local.get 3
      i32.store offset=24
      return
    end)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17habc5b0b62eef023bE (type 6) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32)
    i32.const 0
    local.set 3
    block  ;; label = @1
      local.get 2
      i32.const 256
      i32.lt_u
      br_if 0 (;@1;)
      i32.const 31
      local.set 3
      local.get 2
      i32.const 16777215
      i32.gt_u
      br_if 0 (;@1;)
      local.get 2
      i32.const 6
      local.get 2
      i32.const 8
      i32.shr_u
      i32.clz
      local.tee 3
      i32.sub
      i32.shr_u
      i32.const 1
      i32.and
      local.get 3
      i32.const 1
      i32.shl
      i32.sub
      i32.const 62
      i32.add
      local.set 3
    end
    local.get 1
    i64.const 0
    i64.store offset=16 align=4
    local.get 1
    local.get 3
    i32.store offset=28
    local.get 1
    call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h593cb0bc6379ebafE
    local.set 4
    local.get 0
    local.get 3
    i32.const 2
    i32.shl
    i32.add
    i32.const 272
    i32.add
    local.set 5
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.const 4
              i32.add
              local.tee 0
              i32.load
              local.tee 6
              i32.const 1
              local.get 3
              i32.shl
              local.tee 7
              i32.and
              i32.eqz
              br_if 0 (;@5;)
              local.get 5
              i32.load
              local.set 5
              local.get 3
              call $_ZN8dlmalloc8dlmalloc24leftshift_for_tree_index17hd789c537cab28411E
              local.set 3
              local.get 5
              call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h593cb0bc6379ebafE
              call $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E
              local.get 2
              i32.ne
              br_if 1 (;@4;)
              local.get 5
              local.set 3
              br 2 (;@3;)
            end
            local.get 0
            local.get 6
            local.get 7
            i32.or
            i32.store
            local.get 1
            local.get 5
            i32.store offset=24
            local.get 5
            local.get 1
            i32.store
            br 3 (;@1;)
          end
          local.get 2
          local.get 3
          i32.shl
          local.set 0
          loop  ;; label = @4
            local.get 5
            local.get 0
            i32.const 29
            i32.shr_u
            i32.const 4
            i32.and
            i32.add
            i32.const 16
            i32.add
            local.tee 6
            i32.load
            local.tee 3
            i32.eqz
            br_if 2 (;@2;)
            local.get 0
            i32.const 1
            i32.shl
            local.set 0
            local.get 3
            local.set 5
            local.get 3
            call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h593cb0bc6379ebafE
            call $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E
            local.get 2
            i32.ne
            br_if 0 (;@4;)
          end
        end
        local.get 3
        call $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h593cb0bc6379ebafE
        local.tee 3
        i32.load offset=8
        local.tee 0
        local.get 4
        i32.store offset=12
        local.get 3
        local.get 4
        i32.store offset=8
        local.get 4
        local.get 3
        i32.store offset=12
        local.get 4
        local.get 0
        i32.store offset=8
        local.get 1
        i32.const 0
        i32.store offset=24
        return
      end
      local.get 6
      local.get 1
      i32.store
      local.get 1
      local.get 5
      i32.store offset=24
    end
    local.get 4
    local.get 4
    i32.store offset=8
    local.get 4
    local.get 4
    i32.store offset=12)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$23release_unused_segments17h75b413e6a85f4b60E (type 4) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      local.get 0
      i32.const 432
      i32.add
      i32.load
      local.tee 1
      br_if 0 (;@1;)
      local.get 0
      i32.const 4095
      i32.store offset=448
      i32.const 0
      return
    end
    local.get 0
    i32.const 424
    i32.add
    local.set 2
    i32.const 0
    local.set 3
    i32.const 0
    local.set 4
    loop  ;; label = @1
      local.get 1
      local.tee 5
      i32.load offset=8
      local.set 1
      local.get 5
      i32.load offset=4
      local.set 6
      local.get 5
      i32.load
      local.set 7
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          local.get 5
          i32.const 12
          i32.add
          i32.load
          i32.const 1
          i32.shr_u
          call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$16can_release_part17ha9587956c545036fE
          i32.eqz
          br_if 0 (;@3;)
          local.get 5
          call $_ZN8dlmalloc8dlmalloc7Segment9is_extern17h775061e2c0d47378E
          br_if 0 (;@3;)
          local.get 7
          local.get 7
          call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
          local.tee 8
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          local.get 8
          i32.sub
          i32.add
          local.tee 8
          call $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E
          local.set 9
          call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h3a01fed98ec6278aE
          local.tee 10
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          local.set 11
          i32.const 20
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          local.set 12
          i32.const 16
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          local.set 13
          local.get 8
          call $_ZN8dlmalloc8dlmalloc5Chunk5inuse17h4d9d8a6e39f8aee5E
          br_if 0 (;@3;)
          local.get 8
          local.get 9
          i32.add
          local.get 7
          local.get 10
          local.get 6
          i32.add
          local.get 11
          local.get 12
          i32.add
          local.get 13
          i32.add
          i32.sub
          i32.add
          i32.lt_u
          br_if 0 (;@3;)
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.load offset=408
              local.get 8
              i32.eq
              br_if 0 (;@5;)
              local.get 0
              local.get 8
              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h2484774ef561a518E
              br 1 (;@4;)
            end
            local.get 0
            i32.const 0
            i32.store offset=400
            local.get 0
            i32.const 0
            i32.store offset=408
          end
          block  ;; label = @4
            local.get 0
            local.get 7
            local.get 6
            call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$4free17hc004ad78b71528d6E
            br_if 0 (;@4;)
            local.get 0
            local.get 8
            local.get 9
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17habc5b0b62eef023bE
            br 1 (;@3;)
          end
          local.get 0
          local.get 0
          i32.load offset=416
          local.get 6
          i32.sub
          i32.store offset=416
          local.get 2
          local.get 1
          i32.store offset=8
          local.get 6
          local.get 3
          i32.add
          local.set 3
          br 1 (;@2;)
        end
        local.get 5
        local.set 2
      end
      local.get 4
      i32.const 1
      i32.add
      local.set 4
      local.get 1
      br_if 0 (;@1;)
    end
    local.get 0
    local.get 4
    i32.const 4095
    local.get 4
    i32.const 4095
    i32.gt_u
    select
    i32.store offset=448
    local.get 3)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17hd094ddfe28573441E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32)
    local.get 1
    call $_ZN8dlmalloc8dlmalloc5Chunk8from_mem17h3404f9b5c5e6d4a5E
    local.set 1
    local.get 1
    local.get 1
    call $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E
    local.tee 2
    call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
    local.set 3
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          call $_ZN8dlmalloc8dlmalloc5Chunk6pinuse17h89f5f80c1a4cb95aE
          br_if 0 (;@3;)
          local.get 1
          i32.load
          local.set 4
          block  ;; label = @4
            block  ;; label = @5
              local.get 1
              call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h56605450e209003dE
              br_if 0 (;@5;)
              local.get 4
              local.get 2
              i32.add
              local.set 2
              local.get 1
              local.get 4
              call $_ZN8dlmalloc8dlmalloc5Chunk12minus_offset17h39dd10694c91288eE
              local.tee 1
              local.get 0
              i32.load offset=408
              i32.ne
              br_if 1 (;@4;)
              local.get 3
              i32.load offset=4
              i32.const 3
              i32.and
              i32.const 3
              i32.ne
              br_if 2 (;@3;)
              local.get 0
              local.get 2
              i32.store offset=400
              local.get 1
              local.get 2
              local.get 3
              call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h9991ae3d78ae1397E
              return
            end
            local.get 0
            local.get 1
            local.get 4
            i32.sub
            local.get 4
            local.get 2
            i32.add
            i32.const 16
            i32.add
            local.tee 1
            call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$4free17hc004ad78b71528d6E
            i32.eqz
            br_if 2 (;@2;)
            local.get 0
            local.get 0
            i32.load offset=416
            local.get 1
            i32.sub
            i32.store offset=416
            return
          end
          block  ;; label = @4
            local.get 4
            i32.const 256
            i32.lt_u
            br_if 0 (;@4;)
            local.get 0
            local.get 1
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h2484774ef561a518E
            br 1 (;@3;)
          end
          block  ;; label = @4
            local.get 1
            i32.const 12
            i32.add
            i32.load
            local.tee 5
            local.get 1
            i32.const 8
            i32.add
            i32.load
            local.tee 6
            i32.eq
            br_if 0 (;@4;)
            local.get 6
            local.get 5
            i32.store offset=12
            local.get 5
            local.get 6
            i32.store offset=8
            br 1 (;@3;)
          end
          local.get 0
          local.get 0
          i32.load
          i32.const -2
          local.get 4
          i32.const 3
          i32.shr_u
          i32.rotl
          i32.and
          i32.store
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            call $_ZN8dlmalloc8dlmalloc5Chunk6cinuse17h59613f998488ffb3E
            i32.eqz
            br_if 0 (;@4;)
            local.get 1
            local.get 2
            local.get 3
            call $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h9991ae3d78ae1397E
            br 1 (;@3;)
          end
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 3
                  local.get 0
                  i32.load offset=412
                  i32.eq
                  br_if 0 (;@7;)
                  local.get 3
                  local.get 0
                  i32.load offset=408
                  i32.ne
                  br_if 1 (;@6;)
                  local.get 0
                  local.get 1
                  i32.store offset=408
                  local.get 0
                  local.get 0
                  i32.load offset=400
                  local.get 2
                  i32.add
                  local.tee 2
                  i32.store offset=400
                  local.get 1
                  local.get 2
                  call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17h74d4897d77859f14E
                  return
                end
                local.get 0
                local.get 1
                i32.store offset=412
                local.get 0
                local.get 0
                i32.load offset=404
                local.get 2
                i32.add
                local.tee 2
                i32.store offset=404
                local.get 1
                local.get 2
                i32.const 1
                i32.or
                i32.store offset=4
                local.get 1
                local.get 0
                i32.load offset=408
                i32.eq
                br_if 1 (;@5;)
                br 2 (;@4;)
              end
              local.get 3
              call $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E
              local.tee 4
              local.get 2
              i32.add
              local.set 2
              block  ;; label = @6
                block  ;; label = @7
                  local.get 4
                  i32.const 256
                  i32.lt_u
                  br_if 0 (;@7;)
                  local.get 0
                  local.get 3
                  call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h2484774ef561a518E
                  br 1 (;@6;)
                end
                block  ;; label = @7
                  local.get 3
                  i32.const 12
                  i32.add
                  i32.load
                  local.tee 5
                  local.get 3
                  i32.const 8
                  i32.add
                  i32.load
                  local.tee 3
                  i32.eq
                  br_if 0 (;@7;)
                  local.get 3
                  local.get 5
                  i32.store offset=12
                  local.get 5
                  local.get 3
                  i32.store offset=8
                  br 1 (;@6;)
                end
                local.get 0
                local.get 0
                i32.load
                i32.const -2
                local.get 4
                i32.const 3
                i32.shr_u
                i32.rotl
                i32.and
                i32.store
              end
              local.get 1
              local.get 2
              call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17h74d4897d77859f14E
              local.get 1
              local.get 0
              i32.load offset=408
              i32.ne
              br_if 2 (;@3;)
              local.get 0
              local.get 2
              i32.store offset=400
              br 3 (;@2;)
            end
            local.get 0
            i32.const 0
            i32.store offset=400
            local.get 0
            i32.const 0
            i32.store offset=408
          end
          local.get 0
          i32.const 440
          i32.add
          i32.load
          local.get 2
          i32.ge_u
          br_if 1 (;@2;)
          call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h3a01fed98ec6278aE
          local.set 1
          local.get 1
          local.get 1
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          i32.const 20
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          i32.add
          i32.const 16
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          i32.add
          i32.sub
          i32.const -65544
          i32.add
          i32.const -9
          i32.and
          i32.const -3
          i32.add
          local.tee 1
          i32.const 0
          i32.const 16
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          i32.const 2
          i32.shl
          i32.sub
          local.tee 2
          local.get 2
          local.get 1
          i32.gt_u
          select
          i32.eqz
          br_if 1 (;@2;)
          local.get 0
          i32.load offset=412
          local.tee 2
          i32.eqz
          br_if 1 (;@2;)
          call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h3a01fed98ec6278aE
          local.tee 1
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          local.set 3
          i32.const 20
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          local.set 5
          i32.const 16
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          local.set 6
          i32.const 0
          local.set 4
          block  ;; label = @4
            local.get 0
            i32.load offset=404
            local.tee 7
            local.get 6
            local.get 5
            local.get 3
            local.get 1
            i32.sub
            i32.add
            i32.add
            local.tee 1
            i32.le_u
            br_if 0 (;@4;)
            local.get 7
            local.get 1
            i32.const -1
            i32.xor
            i32.add
            i32.const -65536
            i32.and
            local.set 5
            local.get 0
            i32.const 424
            i32.add
            local.tee 3
            local.set 1
            block  ;; label = @5
              loop  ;; label = @6
                block  ;; label = @7
                  local.get 1
                  i32.load
                  local.get 2
                  i32.gt_u
                  br_if 0 (;@7;)
                  local.get 1
                  call $_ZN8dlmalloc8dlmalloc7Segment3top17he89977119f2095b0E
                  local.get 2
                  i32.gt_u
                  br_if 2 (;@5;)
                end
                local.get 1
                i32.load offset=8
                local.tee 1
                br_if 0 (;@6;)
              end
              i32.const 0
              local.set 1
            end
            i32.const 0
            local.set 4
            local.get 1
            call $_ZN8dlmalloc8dlmalloc7Segment9is_extern17h775061e2c0d47378E
            br_if 0 (;@4;)
            i32.const 0
            local.set 4
            local.get 0
            local.get 1
            i32.const 12
            i32.add
            i32.load
            i32.const 1
            i32.shr_u
            call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$16can_release_part17ha9587956c545036fE
            i32.eqz
            br_if 0 (;@4;)
            i32.const 0
            local.set 4
            local.get 1
            i32.load offset=4
            local.get 5
            i32.lt_u
            br_if 0 (;@4;)
            loop  ;; label = @5
              block  ;; label = @6
                local.get 1
                local.get 3
                call $_ZN8dlmalloc8dlmalloc7Segment5holds17h276a4b63e2947208E
                i32.eqz
                br_if 0 (;@6;)
                i32.const 0
                local.set 4
                br 2 (;@4;)
              end
              local.get 3
              i32.load offset=8
              local.tee 3
              br_if 0 (;@5;)
            end
            i32.const 0
            local.set 4
            local.get 0
            local.get 1
            i32.load
            local.get 1
            i32.load offset=4
            local.tee 2
            local.get 2
            local.get 5
            i32.sub
            call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$9free_part17hfe7db7a0188c71a3E
            i32.eqz
            br_if 0 (;@4;)
            i32.const 0
            local.set 4
            local.get 5
            i32.eqz
            br_if 0 (;@4;)
            local.get 1
            local.get 1
            i32.load offset=4
            local.get 5
            i32.sub
            i32.store offset=4
            local.get 0
            local.get 0
            i32.load offset=416
            local.get 5
            i32.sub
            i32.store offset=416
            local.get 0
            i32.load offset=404
            local.set 2
            local.get 0
            i32.load offset=412
            local.set 1
            local.get 0
            local.get 1
            local.get 1
            call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
            local.tee 3
            i32.const 8
            call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
            local.get 3
            i32.sub
            local.tee 3
            call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
            local.tee 1
            i32.store offset=412
            local.get 0
            local.get 2
            local.get 5
            local.get 3
            i32.add
            i32.sub
            local.tee 2
            i32.store offset=404
            local.get 1
            local.get 2
            i32.const 1
            i32.or
            i32.store offset=4
            call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h3a01fed98ec6278aE
            local.tee 3
            i32.const 8
            call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
            local.set 4
            i32.const 20
            i32.const 8
            call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
            local.set 6
            i32.const 16
            i32.const 8
            call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
            local.set 7
            local.get 1
            local.get 2
            call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
            local.set 1
            local.get 0
            i32.const 440
            i32.add
            i32.const 2097152
            i32.store
            local.get 1
            local.get 7
            local.get 6
            local.get 4
            local.get 3
            i32.sub
            i32.add
            i32.add
            i32.store offset=4
            local.get 5
            local.set 4
          end
          local.get 4
          i32.const 0
          local.get 0
          call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$23release_unused_segments17h75b413e6a85f4b60E
          i32.sub
          i32.ne
          br_if 1 (;@2;)
          local.get 0
          i32.load offset=404
          local.get 0
          i32.const 440
          i32.add
          i32.load
          i32.le_u
          br_if 1 (;@2;)
          local.get 0
          i32.const 440
          i32.add
          i32.const -1
          i32.store
          return
        end
        local.get 2
        i32.const 256
        i32.lt_u
        br_if 1 (;@1;)
        local.get 0
        local.get 1
        local.get 2
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17habc5b0b62eef023bE
        local.get 0
        local.get 0
        i32.load offset=448
        i32.const -1
        i32.add
        local.tee 1
        i32.store offset=448
        local.get 1
        br_if 0 (;@2;)
        local.get 0
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$23release_unused_segments17h75b413e6a85f4b60E
        drop
        return
      end
      return
    end
    local.get 0
    local.get 2
    i32.const 3
    i32.shr_u
    local.tee 3
    i32.const 3
    i32.shl
    i32.add
    i32.const 8
    i32.add
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load
        local.tee 4
        i32.const 1
        local.get 3
        i32.shl
        local.tee 3
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        i32.load offset=8
        local.set 0
        br 1 (;@1;)
      end
      local.get 0
      local.get 4
      local.get 3
      i32.or
      i32.store
      local.get 2
      local.set 0
    end
    local.get 2
    local.get 1
    i32.store offset=8
    local.get 0
    local.get 1
    i32.store offset=12
    local.get 1
    local.get 2
    i32.store offset=12
    local.get 1
    local.get 0
    i32.store offset=8)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8init_top17h9ba4d179485fee16E (type 6) (param i32 i32 i32)
    (local i32 i32 i32 i32)
    local.get 1
    local.get 1
    call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE
    local.tee 3
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
    local.get 3
    i32.sub
    local.tee 3
    call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
    local.set 1
    local.get 0
    local.get 2
    local.get 3
    i32.sub
    local.tee 2
    i32.store offset=404
    local.get 0
    local.get 1
    i32.store offset=412
    local.get 1
    local.get 2
    i32.const 1
    i32.or
    i32.store offset=4
    call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h3a01fed98ec6278aE
    local.tee 3
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
    local.set 4
    i32.const 20
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
    local.set 5
    i32.const 16
    i32.const 8
    call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
    local.set 6
    local.get 1
    local.get 2
    call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
    local.set 1
    local.get 0
    i32.const 2097152
    i32.store offset=440
    local.get 1
    local.get 6
    local.get 5
    local.get 4
    local.get 3
    i32.sub
    i32.add
    i32.add
    i32.store offset=4)
  (func $_ZN3std7process5abort17hf7c8bef35d3938e7E (type 5)
    unreachable
    unreachable)
  (func $_ZN3std10sys_common9backtrace26__rust_end_short_backtrace17h2fbd4fbce4e28992E (type 3) (param i32)
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    local.get 0
    i32.load offset=8
    call $_ZN3std9panicking19begin_panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17h10b3e336a178d4b8E
    unreachable)
  (func $_ZN3std9panicking19begin_panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17h10b3e336a178d4b8E (type 6) (param i32 i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 0
    i32.const 20
    i32.add
    i32.load
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.const 4
            i32.add
            i32.load
            br_table 0 (;@4;) 1 (;@3;) 3 (;@1;)
          end
          local.get 4
          br_if 2 (;@1;)
          i32.const 1048624
          local.set 0
          i32.const 0
          local.set 4
          br 1 (;@2;)
        end
        local.get 4
        br_if 1 (;@1;)
        local.get 0
        i32.load
        local.tee 0
        i32.load offset=4
        local.set 4
        local.get 0
        i32.load
        local.set 0
      end
      local.get 3
      local.get 4
      i32.store offset=4
      local.get 3
      local.get 0
      i32.store
      local.get 3
      i32.const 1048872
      local.get 1
      call $_ZN4core5panic10panic_info9PanicInfo7message17he101928971688e3bE
      local.get 2
      local.get 1
      call $_ZN4core5panic10panic_info9PanicInfo10can_unwind17h053b4173296e76faE
      call $_ZN3std9panicking20rust_panic_with_hook17ha31f05bceed767a5E
      unreachable
    end
    local.get 3
    i32.const 0
    i32.store offset=4
    local.get 3
    local.get 0
    i32.store
    local.get 3
    i32.const 1048852
    local.get 1
    call $_ZN4core5panic10panic_info9PanicInfo7message17he101928971688e3bE
    local.get 2
    local.get 1
    call $_ZN4core5panic10panic_info9PanicInfo10can_unwind17h053b4173296e76faE
    call $_ZN3std9panicking20rust_panic_with_hook17ha31f05bceed767a5E
    unreachable)
  (func $_ZN3std5alloc24default_alloc_error_hook17heb8eb5c10c24f587E (type 0) (param i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      i32.const 0
      i32.load8_u offset=1049340
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      i32.const 28
      i32.add
      i32.const 1
      i32.store
      local.get 2
      i64.const 2
      i64.store offset=12 align=4
      local.get 2
      i32.const 1048704
      i32.store offset=8
      local.get 2
      i32.const 2
      i32.store offset=36
      local.get 2
      local.get 0
      i32.store offset=44
      local.get 2
      local.get 2
      i32.const 32
      i32.add
      i32.store offset=24
      local.get 2
      local.get 2
      i32.const 44
      i32.add
      i32.store offset=32
      local.get 2
      i32.const 8
      i32.add
      i32.const 1048744
      call $_ZN4core9panicking9panic_fmt17h35029ccc4f395b26E
      unreachable
    end
    local.get 2
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $rust_oom (type 0) (param i32 i32)
    (local i32)
    local.get 0
    local.get 1
    i32.const 0
    i32.load offset=1049376
    local.tee 2
    i32.const 3
    local.get 2
    select
    call_indirect (type 0)
    unreachable
    unreachable)
  (func $__rdl_alloc (type 2) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call $_ZN8dlmalloc17Dlmalloc$LT$A$GT$6malloc17he4572c35964f8c9bE)
  (func $__rdl_dealloc (type 6) (param i32 i32 i32)
    i32.const 1049396
    local.get 0
    call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17hd094ddfe28573441E)
  (func $__rdl_realloc (type 7) (param i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.const 9
            i32.lt_u
            br_if 0 (;@4;)
            local.get 3
            local.get 2
            call $_ZN8dlmalloc17Dlmalloc$LT$A$GT$6malloc17he4572c35964f8c9bE
            local.tee 2
            br_if 1 (;@3;)
            i32.const 0
            return
          end
          call $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h3a01fed98ec6278aE
          local.set 1
          i32.const 0
          local.set 2
          local.get 1
          local.get 1
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          i32.const 20
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          i32.add
          i32.const 16
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          i32.add
          i32.sub
          i32.const -65544
          i32.add
          i32.const -9
          i32.and
          i32.const -3
          i32.add
          local.tee 1
          i32.const 0
          i32.const 16
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          i32.const 2
          i32.shl
          i32.sub
          local.tee 4
          local.get 4
          local.get 1
          i32.gt_u
          select
          local.get 3
          i32.le_u
          br_if 1 (;@2;)
          i32.const 16
          local.get 3
          i32.const 4
          i32.add
          i32.const 16
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          i32.const -5
          i32.add
          local.get 3
          i32.gt_u
          select
          i32.const 8
          call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
          local.set 4
          local.get 0
          call $_ZN8dlmalloc8dlmalloc5Chunk8from_mem17h3404f9b5c5e6d4a5E
          local.set 1
          local.get 1
          local.get 1
          call $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E
          local.tee 5
          call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
          local.set 6
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 1
                          call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h56605450e209003dE
                          br_if 0 (;@11;)
                          local.get 5
                          local.get 4
                          i32.ge_u
                          br_if 1 (;@10;)
                          local.get 6
                          i32.const 0
                          i32.load offset=1049808
                          i32.eq
                          br_if 2 (;@9;)
                          local.get 6
                          i32.const 0
                          i32.load offset=1049804
                          i32.eq
                          br_if 3 (;@8;)
                          local.get 6
                          call $_ZN8dlmalloc8dlmalloc5Chunk6cinuse17h59613f998488ffb3E
                          br_if 7 (;@4;)
                          local.get 6
                          call $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E
                          local.tee 7
                          local.get 5
                          i32.add
                          local.tee 5
                          local.get 4
                          i32.lt_u
                          br_if 7 (;@4;)
                          local.get 5
                          local.get 4
                          i32.sub
                          local.set 8
                          local.get 7
                          i32.const 256
                          i32.lt_u
                          br_if 4 (;@7;)
                          i32.const 1049396
                          local.get 6
                          call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18unlink_large_chunk17h2484774ef561a518E
                          br 5 (;@6;)
                        end
                        local.get 1
                        call $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E
                        local.set 5
                        local.get 4
                        i32.const 256
                        i32.lt_u
                        br_if 6 (;@4;)
                        block  ;; label = @11
                          local.get 5
                          local.get 4
                          i32.const 4
                          i32.add
                          i32.lt_u
                          br_if 0 (;@11;)
                          local.get 5
                          local.get 4
                          i32.sub
                          i32.const 131073
                          i32.lt_u
                          br_if 6 (;@5;)
                        end
                        i32.const 1049396
                        local.get 1
                        local.get 1
                        i32.load
                        local.tee 6
                        i32.sub
                        local.get 5
                        local.get 6
                        i32.add
                        i32.const 16
                        i32.add
                        local.tee 7
                        local.get 4
                        i32.const 31
                        i32.add
                        i32.const 1049396
                        call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$9page_size17hf5189f015a43cc18E
                        call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                        local.tee 5
                        i32.const 1
                        call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$5remap17h737373babb5822ceE
                        local.tee 4
                        i32.eqz
                        br_if 6 (;@4;)
                        local.get 4
                        local.get 6
                        i32.add
                        local.tee 1
                        local.get 5
                        local.get 6
                        i32.sub
                        local.tee 3
                        i32.const -16
                        i32.add
                        local.tee 2
                        i32.store offset=4
                        call $_ZN8dlmalloc8dlmalloc5Chunk14fencepost_head17h32cfaa035be31489E
                        local.set 0
                        local.get 1
                        local.get 2
                        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                        local.get 0
                        i32.store offset=4
                        local.get 1
                        local.get 3
                        i32.const -12
                        i32.add
                        call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                        i32.const 0
                        i32.store offset=4
                        i32.const 0
                        i32.const 0
                        i32.load offset=1049812
                        local.get 5
                        local.get 7
                        i32.sub
                        i32.add
                        local.tee 3
                        i32.store offset=1049812
                        i32.const 0
                        i32.const 0
                        i32.load offset=1049840
                        local.tee 2
                        local.get 4
                        local.get 4
                        local.get 2
                        i32.gt_u
                        select
                        i32.store offset=1049840
                        i32.const 0
                        i32.const 0
                        i32.load offset=1049816
                        local.tee 2
                        local.get 3
                        local.get 2
                        local.get 3
                        i32.gt_u
                        select
                        i32.store offset=1049816
                        br 9 (;@1;)
                      end
                      local.get 5
                      local.get 4
                      i32.sub
                      local.tee 5
                      i32.const 16
                      i32.const 8
                      call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                      i32.lt_u
                      br_if 4 (;@5;)
                      local.get 1
                      local.get 4
                      call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                      local.set 6
                      local.get 1
                      local.get 4
                      call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17hc493611b2d4f74f1E
                      local.get 6
                      local.get 5
                      call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17hc493611b2d4f74f1E
                      local.get 6
                      local.get 5
                      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17h04ab92064f11ad31E
                      br 4 (;@5;)
                    end
                    i32.const 0
                    i32.load offset=1049800
                    local.get 5
                    i32.add
                    local.tee 5
                    local.get 4
                    i32.le_u
                    br_if 4 (;@4;)
                    local.get 1
                    local.get 4
                    call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                    local.set 6
                    local.get 1
                    local.get 4
                    call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17hc493611b2d4f74f1E
                    local.get 6
                    local.get 5
                    local.get 4
                    i32.sub
                    local.tee 4
                    i32.const 1
                    i32.or
                    i32.store offset=4
                    i32.const 0
                    local.get 4
                    i32.store offset=1049800
                    i32.const 0
                    local.get 6
                    i32.store offset=1049808
                    br 3 (;@5;)
                  end
                  i32.const 0
                  i32.load offset=1049796
                  local.get 5
                  i32.add
                  local.tee 5
                  local.get 4
                  i32.lt_u
                  br_if 3 (;@4;)
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 5
                      local.get 4
                      i32.sub
                      local.tee 6
                      i32.const 16
                      i32.const 8
                      call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                      i32.ge_u
                      br_if 0 (;@9;)
                      local.get 1
                      local.get 5
                      call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17hc493611b2d4f74f1E
                      i32.const 0
                      local.set 6
                      i32.const 0
                      local.set 5
                      br 1 (;@8;)
                    end
                    local.get 1
                    local.get 4
                    call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                    local.tee 5
                    local.get 6
                    call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                    local.set 7
                    local.get 1
                    local.get 4
                    call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17hc493611b2d4f74f1E
                    local.get 5
                    local.get 6
                    call $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17h74d4897d77859f14E
                    local.get 7
                    call $_ZN8dlmalloc8dlmalloc5Chunk12clear_pinuse17h2a67940d6f74a782E
                  end
                  i32.const 0
                  local.get 5
                  i32.store offset=1049804
                  i32.const 0
                  local.get 6
                  i32.store offset=1049796
                  br 2 (;@5;)
                end
                block  ;; label = @7
                  local.get 6
                  i32.const 12
                  i32.add
                  i32.load
                  local.tee 9
                  local.get 6
                  i32.const 8
                  i32.add
                  i32.load
                  local.tee 6
                  i32.eq
                  br_if 0 (;@7;)
                  local.get 6
                  local.get 9
                  i32.store offset=12
                  local.get 9
                  local.get 6
                  i32.store offset=8
                  br 1 (;@6;)
                end
                i32.const 0
                i32.const 0
                i32.load offset=1049396
                i32.const -2
                local.get 7
                i32.const 3
                i32.shr_u
                i32.rotl
                i32.and
                i32.store offset=1049396
              end
              block  ;; label = @6
                local.get 8
                i32.const 16
                i32.const 8
                call $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E
                i32.lt_u
                br_if 0 (;@6;)
                local.get 1
                local.get 4
                call $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E
                local.set 5
                local.get 1
                local.get 4
                call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17hc493611b2d4f74f1E
                local.get 5
                local.get 8
                call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17hc493611b2d4f74f1E
                local.get 5
                local.get 8
                call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17h04ab92064f11ad31E
                br 1 (;@5;)
              end
              local.get 1
              local.get 5
              call $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17hc493611b2d4f74f1E
            end
            local.get 1
            br_if 3 (;@1;)
          end
          local.get 3
          call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h1bd11c33484481a4E
          local.tee 4
          i32.eqz
          br_if 1 (;@2;)
          local.get 4
          local.get 0
          local.get 3
          local.get 1
          call $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E
          i32.const -8
          i32.const -4
          local.get 1
          call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h56605450e209003dE
          select
          i32.add
          local.tee 2
          local.get 2
          local.get 3
          i32.gt_u
          select
          call $memcpy
          local.set 3
          i32.const 1049396
          local.get 0
          call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17hd094ddfe28573441E
          local.get 3
          return
        end
        local.get 2
        local.get 0
        local.get 3
        local.get 1
        local.get 1
        local.get 3
        i32.gt_u
        select
        call $memcpy
        drop
        i32.const 1049396
        local.get 0
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17hd094ddfe28573441E
      end
      local.get 2
      return
    end
    local.get 1
    call $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h56605450e209003dE
    drop
    local.get 1
    call $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE)
  (func $rust_begin_unwind (type 3) (param i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        call $_ZN4core5panic10panic_info9PanicInfo8location17h63e6170dfebcfc8aE
        local.tee 2
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        call $_ZN4core5panic10panic_info9PanicInfo7message17he101928971688e3bE
        local.tee 3
        i32.eqz
        br_if 1 (;@1;)
        local.get 1
        local.get 2
        i32.store offset=8
        local.get 1
        local.get 0
        i32.store offset=4
        local.get 1
        local.get 3
        i32.store
        local.get 1
        call $_ZN3std10sys_common9backtrace26__rust_end_short_backtrace17h2fbd4fbce4e28992E
        unreachable
      end
      i32.const 1048624
      i32.const 43
      i32.const 1048804
      call $_ZN4core9panicking5panic17ha4be2267b4d7eb1bE
      unreachable
    end
    i32.const 1048624
    i32.const 43
    i32.const 1048788
    call $_ZN4core9panicking5panic17ha4be2267b4d7eb1bE
    unreachable)
  (func $_ZN90_$LT$std..panicking..begin_panic_handler..PanicPayload$u20$as$u20$core..panic..BoxMeUp$GT$8take_box17hf88e93ea97bf61d3E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 1
    i32.const 4
    i32.add
    local.set 3
    block  ;; label = @1
      local.get 1
      i32.load offset=4
      br_if 0 (;@1;)
      local.get 1
      i32.load
      local.set 4
      local.get 2
      i32.const 8
      i32.add
      i32.const 8
      i32.add
      local.tee 5
      i32.const 0
      i32.store
      local.get 2
      i64.const 1
      i64.store offset=8
      local.get 2
      local.get 2
      i32.const 8
      i32.add
      i32.store offset=20
      local.get 2
      i32.const 24
      i32.add
      i32.const 16
      i32.add
      local.get 4
      i32.const 16
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      i32.const 24
      i32.add
      i32.const 8
      i32.add
      local.get 4
      i32.const 8
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      local.get 4
      i64.load align=4
      i64.store offset=24
      local.get 2
      i32.const 20
      i32.add
      i32.const 1048600
      local.get 2
      i32.const 24
      i32.add
      call $_ZN4core3fmt5write17h62b20074abd80558E
      drop
      local.get 3
      i32.const 8
      i32.add
      local.get 5
      i32.load
      i32.store
      local.get 3
      local.get 2
      i64.load offset=8
      i64.store align=4
    end
    local.get 2
    i32.const 24
    i32.add
    i32.const 8
    i32.add
    local.tee 4
    local.get 3
    i32.const 8
    i32.add
    i32.load
    i32.store
    local.get 1
    i32.const 12
    i32.add
    i32.const 0
    i32.store
    local.get 3
    i64.load align=4
    local.set 6
    local.get 1
    i64.const 1
    i64.store offset=4 align=4
    local.get 2
    local.get 6
    i64.store offset=24
    block  ;; label = @1
      i32.const 12
      i32.const 4
      call $__rust_alloc
      local.tee 1
      br_if 0 (;@1;)
      i32.const 12
      i32.const 4
      call $_ZN5alloc5alloc18handle_alloc_error17h42b2ac242981c6baE
      unreachable
    end
    local.get 1
    local.get 2
    i64.load offset=24
    i64.store align=4
    local.get 1
    i32.const 8
    i32.add
    local.get 4
    i32.load
    i32.store
    local.get 0
    i32.const 1048820
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    local.get 2
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $_ZN90_$LT$std..panicking..begin_panic_handler..PanicPayload$u20$as$u20$core..panic..BoxMeUp$GT$3get17h97c25dff6adc9fe7E (type 0) (param i32 i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 1
    i32.const 4
    i32.add
    local.set 3
    block  ;; label = @1
      local.get 1
      i32.load offset=4
      br_if 0 (;@1;)
      local.get 1
      i32.load
      local.set 1
      local.get 2
      i32.const 8
      i32.add
      i32.const 8
      i32.add
      local.tee 4
      i32.const 0
      i32.store
      local.get 2
      i64.const 1
      i64.store offset=8
      local.get 2
      local.get 2
      i32.const 8
      i32.add
      i32.store offset=20
      local.get 2
      i32.const 24
      i32.add
      i32.const 16
      i32.add
      local.get 1
      i32.const 16
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      i32.const 24
      i32.add
      i32.const 8
      i32.add
      local.get 1
      i32.const 8
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      local.get 1
      i64.load align=4
      i64.store offset=24
      local.get 2
      i32.const 20
      i32.add
      i32.const 1048600
      local.get 2
      i32.const 24
      i32.add
      call $_ZN4core3fmt5write17h62b20074abd80558E
      drop
      local.get 3
      i32.const 8
      i32.add
      local.get 4
      i32.load
      i32.store
      local.get 3
      local.get 2
      i64.load offset=8
      i64.store align=4
    end
    local.get 0
    i32.const 1048820
    i32.store offset=4
    local.get 0
    local.get 3
    i32.store
    local.get 2
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $_ZN93_$LT$std..panicking..begin_panic_handler..StrPanicPayload$u20$as$u20$core..panic..BoxMeUp$GT$8take_box17h6910e5e3b12a5c08E (type 0) (param i32 i32)
    (local i32 i32)
    local.get 1
    i32.load offset=4
    local.set 2
    local.get 1
    i32.load
    local.set 3
    block  ;; label = @1
      i32.const 8
      i32.const 4
      call $__rust_alloc
      local.tee 1
      br_if 0 (;@1;)
      i32.const 8
      i32.const 4
      call $_ZN5alloc5alloc18handle_alloc_error17h42b2ac242981c6baE
      unreachable
    end
    local.get 1
    local.get 2
    i32.store offset=4
    local.get 1
    local.get 3
    i32.store
    local.get 0
    i32.const 1048836
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func $_ZN93_$LT$std..panicking..begin_panic_handler..StrPanicPayload$u20$as$u20$core..panic..BoxMeUp$GT$3get17haf427899f1e3b0d6E (type 0) (param i32 i32)
    local.get 0
    i32.const 1048836
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func $_ZN3std9panicking20rust_panic_with_hook17ha31f05bceed767a5E (type 11) (param i32 i32 i32 i32 i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    i32.const 0
    i32.const 0
    i32.load offset=1049392
    local.tee 6
    i32.const 1
    i32.add
    i32.store offset=1049392
    i32.const 0
    i32.const 0
    i32.load offset=1049848
    i32.const 1
    i32.add
    local.tee 7
    i32.store offset=1049848
    block  ;; label = @1
      block  ;; label = @2
        local.get 6
        i32.const 0
        i32.lt_s
        br_if 0 (;@2;)
        local.get 7
        i32.const 2
        i32.gt_u
        br_if 0 (;@2;)
        local.get 5
        local.get 4
        i32.store8 offset=24
        local.get 5
        local.get 3
        i32.store offset=20
        local.get 5
        local.get 2
        i32.store offset=16
        i32.const 0
        i32.load offset=1049380
        local.tee 6
        i32.const -1
        i32.le_s
        br_if 0 (;@2;)
        i32.const 0
        local.get 6
        i32.const 1
        i32.add
        local.tee 6
        i32.store offset=1049380
        block  ;; label = @3
          i32.const 0
          i32.load offset=1049388
          local.tee 2
          i32.eqz
          br_if 0 (;@3;)
          i32.const 0
          i32.load offset=1049384
          local.set 6
          local.get 5
          local.get 0
          local.get 1
          i32.load offset=16
          call_indirect (type 0)
          local.get 5
          local.get 5
          i64.load
          i64.store offset=8
          local.get 6
          local.get 5
          i32.const 8
          i32.add
          local.get 2
          i32.load offset=20
          call_indirect (type 0)
          i32.const 0
          i32.load offset=1049380
          local.set 6
        end
        i32.const 0
        local.get 6
        i32.const -1
        i32.add
        i32.store offset=1049380
        local.get 7
        i32.const 1
        i32.gt_u
        br_if 0 (;@2;)
        local.get 4
        br_if 1 (;@1;)
      end
      unreachable
      unreachable
    end
    local.get 0
    local.get 1
    call $rust_panic
    unreachable)
  (func $rust_panic (type 0) (param i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    local.get 1
    i32.store offset=12
    local.get 2
    local.get 0
    i32.store offset=8
    local.get 2
    i32.const 8
    i32.add
    call $__rust_start_panic
    drop
    unreachable
    unreachable)
  (func $__rust_start_panic (type 4) (param i32) (result i32)
    unreachable
    unreachable)
  (func $_ZN8dlmalloc8dlmalloc8align_up17hd9eacdb194c331e3E (type 2) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.add
    i32.const -1
    i32.add
    i32.const 0
    local.get 1
    i32.sub
    i32.and)
  (func $_ZN8dlmalloc8dlmalloc9left_bits17hd43e75bebd2d32bdE (type 4) (param i32) (result i32)
    local.get 0
    i32.const 1
    i32.shl
    local.tee 0
    i32.const 0
    local.get 0
    i32.sub
    i32.or)
  (func $_ZN8dlmalloc8dlmalloc9least_bit17hc868b6f46985b42bE (type 4) (param i32) (result i32)
    i32.const 0
    local.get 0
    i32.sub
    local.get 0
    i32.and)
  (func $_ZN8dlmalloc8dlmalloc24leftshift_for_tree_index17hd789c537cab28411E (type 4) (param i32) (result i32)
    i32.const 0
    i32.const 25
    local.get 0
    i32.const 1
    i32.shr_u
    i32.sub
    local.get 0
    i32.const 31
    i32.eq
    select)
  (func $_ZN8dlmalloc8dlmalloc5Chunk14fencepost_head17h32cfaa035be31489E (type 8) (result i32)
    i32.const 7)
  (func $_ZN8dlmalloc8dlmalloc5Chunk4size17h2c45c180b65c3224E (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=4
    i32.const -8
    i32.and)
  (func $_ZN8dlmalloc8dlmalloc5Chunk6cinuse17h59613f998488ffb3E (type 4) (param i32) (result i32)
    local.get 0
    i32.load8_u offset=4
    i32.const 2
    i32.and
    i32.const 1
    i32.shr_u)
  (func $_ZN8dlmalloc8dlmalloc5Chunk6pinuse17h89f5f80c1a4cb95aE (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=4
    i32.const 1
    i32.and)
  (func $_ZN8dlmalloc8dlmalloc5Chunk12clear_pinuse17h2a67940d6f74a782E (type 3) (param i32)
    local.get 0
    local.get 0
    i32.load offset=4
    i32.const -2
    i32.and
    i32.store offset=4)
  (func $_ZN8dlmalloc8dlmalloc5Chunk5inuse17h4d9d8a6e39f8aee5E (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=4
    i32.const 3
    i32.and
    i32.const 1
    i32.ne)
  (func $_ZN8dlmalloc8dlmalloc5Chunk7mmapped17h56605450e209003dE (type 4) (param i32) (result i32)
    local.get 0
    i32.load8_u offset=4
    i32.const 3
    i32.and
    i32.eqz)
  (func $_ZN8dlmalloc8dlmalloc5Chunk9set_inuse17hc493611b2d4f74f1E (type 0) (param i32 i32)
    local.get 0
    local.get 0
    i32.load offset=4
    i32.const 1
    i32.and
    local.get 1
    i32.or
    i32.const 2
    i32.or
    i32.store offset=4
    local.get 0
    local.get 1
    i32.add
    local.tee 0
    local.get 0
    i32.load offset=4
    i32.const 1
    i32.or
    i32.store offset=4)
  (func $_ZN8dlmalloc8dlmalloc5Chunk20set_inuse_and_pinuse17ha76eb13dcd83db20E (type 0) (param i32 i32)
    local.get 0
    local.get 1
    i32.const 3
    i32.or
    i32.store offset=4
    local.get 0
    local.get 1
    i32.add
    local.tee 0
    local.get 0
    i32.load offset=4
    i32.const 1
    i32.or
    i32.store offset=4)
  (func $_ZN8dlmalloc8dlmalloc5Chunk34set_size_and_pinuse_of_inuse_chunk17h0f4b537b8fccf023E (type 0) (param i32 i32)
    local.get 0
    local.get 1
    i32.const 3
    i32.or
    i32.store offset=4)
  (func $_ZN8dlmalloc8dlmalloc5Chunk33set_size_and_pinuse_of_free_chunk17h74d4897d77859f14E (type 0) (param i32 i32)
    local.get 0
    local.get 1
    i32.const 1
    i32.or
    i32.store offset=4
    local.get 0
    local.get 1
    i32.add
    local.get 1
    i32.store)
  (func $_ZN8dlmalloc8dlmalloc5Chunk20set_free_with_pinuse17h9991ae3d78ae1397E (type 6) (param i32 i32 i32)
    local.get 2
    local.get 2
    i32.load offset=4
    i32.const -2
    i32.and
    i32.store offset=4
    local.get 0
    local.get 1
    i32.const 1
    i32.or
    i32.store offset=4
    local.get 0
    local.get 1
    i32.add
    local.get 1
    i32.store)
  (func $_ZN8dlmalloc8dlmalloc5Chunk11plus_offset17h2f524ce61dfc67e4E (type 2) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.add)
  (func $_ZN8dlmalloc8dlmalloc5Chunk12minus_offset17h39dd10694c91288eE (type 2) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.sub)
  (func $_ZN8dlmalloc8dlmalloc5Chunk6to_mem17h6d13f3f3c0bfa5daE (type 4) (param i32) (result i32)
    local.get 0
    i32.const 8
    i32.add)
  (func $_ZN8dlmalloc8dlmalloc5Chunk10mem_offset17h3a01fed98ec6278aE (type 8) (result i32)
    i32.const 8)
  (func $_ZN8dlmalloc8dlmalloc5Chunk8from_mem17h3404f9b5c5e6d4a5E (type 4) (param i32) (result i32)
    local.get 0
    i32.const -8
    i32.add)
  (func $_ZN8dlmalloc8dlmalloc9TreeChunk14leftmost_child17h98469de652a23deaE (type 4) (param i32) (result i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load offset=16
      local.tee 1
      br_if 0 (;@1;)
      local.get 0
      i32.const 20
      i32.add
      i32.load
      local.set 1
    end
    local.get 1)
  (func $_ZN8dlmalloc8dlmalloc9TreeChunk5chunk17h593cb0bc6379ebafE (type 4) (param i32) (result i32)
    local.get 0)
  (func $_ZN8dlmalloc8dlmalloc9TreeChunk4next17h656f2e3867c8acf8E (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=12)
  (func $_ZN8dlmalloc8dlmalloc9TreeChunk4prev17h527f673fd8318adbE (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=8)
  (func $_ZN8dlmalloc8dlmalloc7Segment9is_extern17h775061e2c0d47378E (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=12
    i32.const 1
    i32.and)
  (func $_ZN8dlmalloc8dlmalloc7Segment9sys_flags17h6d168430a1d92f9aE (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=12
    i32.const 1
    i32.shr_u)
  (func $_ZN8dlmalloc8dlmalloc7Segment5holds17h276a4b63e2947208E (type 2) (param i32 i32) (result i32)
    (local i32 i32)
    i32.const 0
    local.set 2
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 3
      local.get 1
      i32.gt_u
      br_if 0 (;@1;)
      local.get 3
      local.get 0
      i32.load offset=4
      i32.add
      local.get 1
      i32.gt_u
      local.set 2
    end
    local.get 2)
  (func $_ZN8dlmalloc8dlmalloc7Segment3top17he89977119f2095b0E (type 4) (param i32) (result i32)
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    i32.add)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$5alloc17he1272ca423b0b1b4E (type 6) (param i32 i32 i32)
    (local i32)
    local.get 2
    i32.const 16
    i32.shr_u
    memory.grow
    local.set 3
    local.get 0
    i32.const 0
    i32.store offset=8
    local.get 0
    i32.const 0
    local.get 2
    i32.const -65536
    i32.and
    local.get 3
    i32.const -1
    i32.eq
    local.tee 2
    select
    i32.store offset=4
    local.get 0
    i32.const 0
    local.get 3
    i32.const 16
    i32.shl
    local.get 2
    select
    i32.store)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$5remap17h737373babb5822ceE (type 12) (param i32 i32 i32 i32 i32) (result i32)
    i32.const 0)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$9free_part17hfe7db7a0188c71a3E (type 7) (param i32 i32 i32 i32) (result i32)
    i32.const 0)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$4free17hc004ad78b71528d6E (type 1) (param i32 i32 i32) (result i32)
    i32.const 0)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$16can_release_part17ha9587956c545036fE (type 2) (param i32 i32) (result i32)
    i32.const 0)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$9page_size17hf5189f015a43cc18E (type 4) (param i32) (result i32)
    i32.const 65536)
  (func $_ZN4core3ops8function6FnOnce9call_once17h8357414d3efb843bE (type 0) (param i32 i32)
    local.get 0
    local.get 1
    call $_ZN5alloc5alloc18handle_alloc_error8rt_error17h017aecd060955fedE
    unreachable)
  (func $_ZN5alloc5alloc18handle_alloc_error8rt_error17h017aecd060955fedE (type 0) (param i32 i32)
    local.get 0
    local.get 1
    call $__rust_alloc_error_handler
    unreachable)
  (func $_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17heedb7d44e2f9ac57E (type 3) (param i32))
  (func $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h55342177fb966a77E (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    call $_ZN5alloc6string6String4push17h397bbe516aa300e0E
    i32.const 0)
  (func $_ZN5alloc6string6String4push17h397bbe516aa300e0E (type 0) (param i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.const 128
            i32.lt_u
            br_if 0 (;@4;)
            local.get 2
            i32.const 0
            i32.store offset=12
            local.get 1
            i32.const 2048
            i32.ge_u
            br_if 1 (;@3;)
            local.get 2
            local.get 1
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=13
            local.get 2
            local.get 1
            i32.const 6
            i32.shr_u
            i32.const 192
            i32.or
            i32.store8 offset=12
            i32.const 2
            local.set 1
            br 2 (;@2;)
          end
          block  ;; label = @4
            local.get 0
            i32.load offset=8
            local.tee 3
            local.get 0
            i32.load offset=4
            i32.ne
            br_if 0 (;@4;)
            local.get 0
            local.get 3
            call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17h0eecbd3b27924cbfE
            local.get 0
            i32.load offset=8
            local.set 3
          end
          local.get 0
          local.get 3
          i32.const 1
          i32.add
          i32.store offset=8
          local.get 0
          i32.load
          local.get 3
          i32.add
          local.get 1
          i32.store8
          br 2 (;@1;)
        end
        block  ;; label = @3
          local.get 1
          i32.const 65536
          i32.lt_u
          br_if 0 (;@3;)
          local.get 2
          local.get 1
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=15
          local.get 2
          local.get 1
          i32.const 6
          i32.shr_u
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=14
          local.get 2
          local.get 1
          i32.const 12
          i32.shr_u
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=13
          local.get 2
          local.get 1
          i32.const 18
          i32.shr_u
          i32.const 7
          i32.and
          i32.const 240
          i32.or
          i32.store8 offset=12
          i32.const 4
          local.set 1
          br 1 (;@2;)
        end
        local.get 2
        local.get 1
        i32.const 63
        i32.and
        i32.const 128
        i32.or
        i32.store8 offset=14
        local.get 2
        local.get 1
        i32.const 12
        i32.shr_u
        i32.const 224
        i32.or
        i32.store8 offset=12
        local.get 2
        local.get 1
        i32.const 6
        i32.shr_u
        i32.const 63
        i32.and
        i32.const 128
        i32.or
        i32.store8 offset=13
        i32.const 3
        local.set 1
      end
      block  ;; label = @2
        local.get 0
        i32.const 4
        i32.add
        i32.load
        local.get 0
        i32.load offset=8
        local.tee 3
        i32.sub
        local.get 1
        i32.ge_u
        br_if 0 (;@2;)
        local.get 0
        local.get 3
        local.get 1
        call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17hf25ef7f9e6d380eeE
        local.get 0
        i32.load offset=8
        local.set 3
      end
      local.get 0
      i32.load
      local.get 3
      i32.add
      local.get 2
      i32.const 12
      i32.add
      local.get 1
      call $memcpy
      drop
      local.get 0
      local.get 3
      local.get 1
      i32.add
      i32.store offset=8
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17he9763e63895c0f43E (type 2) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    local.get 0
    i32.load
    i32.store offset=4
    local.get 2
    i32.const 8
    i32.add
    i32.const 16
    i32.add
    local.get 1
    i32.const 16
    i32.add
    i64.load align=4
    i64.store
    local.get 2
    i32.const 8
    i32.add
    i32.const 8
    i32.add
    local.get 1
    i32.const 8
    i32.add
    i64.load align=4
    i64.store
    local.get 2
    local.get 1
    i64.load align=4
    i64.store offset=8
    local.get 2
    i32.const 4
    i32.add
    i32.const 1048892
    local.get 2
    i32.const 8
    i32.add
    call $_ZN4core3fmt5write17h62b20074abd80558E
    local.set 1
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17h0852357214965ee3E (type 1) (param i32 i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 0
      i32.const 4
      i32.add
      i32.load
      local.get 0
      i32.load offset=8
      local.tee 3
      i32.sub
      local.get 2
      i32.ge_u
      br_if 0 (;@1;)
      local.get 0
      local.get 3
      local.get 2
      call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17hf25ef7f9e6d380eeE
      local.get 0
      i32.load offset=8
      local.set 3
    end
    local.get 0
    i32.load
    local.get 3
    i32.add
    local.get 1
    local.get 2
    call $memcpy
    drop
    local.get 0
    local.get 3
    local.get 2
    i32.add
    i32.store offset=8
    i32.const 0)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17hf25ef7f9e6d380eeE (type 6) (param i32 i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        local.get 2
        i32.add
        local.tee 2
        local.get 1
        i32.lt_u
        br_if 0 (;@2;)
        local.get 0
        i32.const 4
        i32.add
        i32.load
        local.tee 1
        i32.const 1
        i32.shl
        local.tee 4
        local.get 2
        local.get 4
        local.get 2
        i32.gt_u
        select
        local.tee 2
        i32.const 8
        local.get 2
        i32.const 8
        i32.gt_u
        select
        local.tee 2
        i32.const -1
        i32.xor
        i32.const 31
        i32.shr_u
        local.set 4
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            br_if 0 (;@4;)
            i32.const 0
            local.set 1
            br 1 (;@3;)
          end
          local.get 3
          local.get 0
          i32.load
          i32.store offset=16
          local.get 3
          local.get 1
          i32.store offset=20
          local.get 1
          i32.const -1
          i32.xor
          i32.const 31
          i32.shr_u
          local.set 1
        end
        local.get 3
        local.get 1
        i32.store offset=24
        local.get 3
        local.get 2
        local.get 4
        local.get 3
        i32.const 16
        i32.add
        call $_ZN5alloc7raw_vec11finish_grow17h3940f26ba580ec0bE
        local.get 3
        i32.load offset=4
        local.set 1
        block  ;; label = @3
          local.get 3
          i32.load
          br_if 0 (;@3;)
          local.get 0
          local.get 1
          i32.store
          local.get 0
          i32.const 4
          i32.add
          local.get 2
          i32.store
          br 2 (;@1;)
        end
        local.get 3
        i32.const 8
        i32.add
        i32.load
        local.tee 0
        i32.const -2147483647
        i32.eq
        br_if 1 (;@1;)
        local.get 0
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        local.get 0
        call $_ZN5alloc5alloc18handle_alloc_error17h42b2ac242981c6baE
        unreachable
      end
      call $_ZN5alloc7raw_vec17capacity_overflow17he8831a0490d21b13E
      unreachable
    end
    local.get 3
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN5alloc7raw_vec11finish_grow17h3940f26ba580ec0bE (type 10) (param i32 i32 i32 i32)
    (local i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 2
                  i32.eqz
                  br_if 0 (;@7;)
                  i32.const 1
                  local.set 4
                  local.get 1
                  i32.const 0
                  i32.lt_s
                  br_if 1 (;@6;)
                  local.get 3
                  i32.load offset=8
                  i32.eqz
                  br_if 3 (;@4;)
                  local.get 3
                  i32.load offset=4
                  local.tee 5
                  br_if 2 (;@5;)
                  local.get 1
                  br_if 4 (;@3;)
                  local.get 2
                  local.set 3
                  br 5 (;@2;)
                end
                local.get 0
                local.get 1
                i32.store offset=4
                i32.const 1
                local.set 4
              end
              i32.const 0
              local.set 1
              br 4 (;@1;)
            end
            local.get 3
            i32.load
            local.get 5
            local.get 2
            local.get 1
            call $__rust_realloc
            local.set 3
            br 2 (;@2;)
          end
          local.get 1
          br_if 0 (;@3;)
          local.get 2
          local.set 3
          br 1 (;@2;)
        end
        local.get 1
        local.get 2
        call $__rust_alloc
        local.set 3
      end
      block  ;; label = @2
        local.get 3
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        local.get 3
        i32.store offset=4
        i32.const 0
        local.set 4
        br 1 (;@1;)
      end
      local.get 0
      local.get 1
      i32.store offset=4
      local.get 2
      local.set 1
    end
    local.get 0
    local.get 4
    i32.store
    local.get 0
    i32.const 8
    i32.add
    local.get 1
    i32.store)
  (func $_ZN5alloc5alloc18handle_alloc_error17h42b2ac242981c6baE (type 0) (param i32 i32)
    local.get 0
    local.get 1
    call $_ZN4core3ops8function6FnOnce9call_once17h8357414d3efb843bE
    unreachable)
  (func $_ZN5alloc7raw_vec17capacity_overflow17he8831a0490d21b13E (type 5)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 0
    global.set $__stack_pointer
    local.get 0
    i32.const 28
    i32.add
    i32.const 0
    i32.store
    local.get 0
    i32.const 1048916
    i32.store offset=24
    local.get 0
    i64.const 1
    i64.store offset=12 align=4
    local.get 0
    i32.const 1048964
    i32.store offset=8
    local.get 0
    i32.const 8
    i32.add
    i32.const 1048972
    call $_ZN4core9panicking9panic_fmt17h35029ccc4f395b26E
    unreachable)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17h0eecbd3b27924cbfE (type 0) (param i32 i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.const 1
        i32.add
        local.tee 3
        local.get 1
        i32.lt_u
        br_if 0 (;@2;)
        local.get 0
        i32.const 4
        i32.add
        i32.load
        local.tee 1
        i32.const 1
        i32.shl
        local.tee 4
        local.get 3
        local.get 4
        local.get 3
        i32.gt_u
        select
        local.tee 3
        i32.const 8
        local.get 3
        i32.const 8
        i32.gt_u
        select
        local.tee 3
        i32.const -1
        i32.xor
        i32.const 31
        i32.shr_u
        local.set 4
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            br_if 0 (;@4;)
            i32.const 0
            local.set 1
            br 1 (;@3;)
          end
          local.get 2
          local.get 0
          i32.load
          i32.store offset=16
          local.get 2
          local.get 1
          i32.store offset=20
          local.get 1
          i32.const -1
          i32.xor
          i32.const 31
          i32.shr_u
          local.set 1
        end
        local.get 2
        local.get 1
        i32.store offset=24
        local.get 2
        local.get 3
        local.get 4
        local.get 2
        i32.const 16
        i32.add
        call $_ZN5alloc7raw_vec11finish_grow17h3940f26ba580ec0bE
        local.get 2
        i32.load offset=4
        local.set 1
        block  ;; label = @3
          local.get 2
          i32.load
          br_if 0 (;@3;)
          local.get 0
          local.get 1
          i32.store
          local.get 0
          i32.const 4
          i32.add
          local.get 3
          i32.store
          br 2 (;@1;)
        end
        local.get 2
        i32.const 8
        i32.add
        i32.load
        local.tee 0
        i32.const -2147483647
        i32.eq
        br_if 1 (;@1;)
        local.get 0
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        local.get 0
        call $_ZN5alloc5alloc18handle_alloc_error17h42b2ac242981c6baE
        unreachable
      end
      call $_ZN5alloc7raw_vec17capacity_overflow17he8831a0490d21b13E
      unreachable
    end
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $__rg_oom (type 0) (param i32 i32)
    local.get 0
    local.get 1
    call $rust_oom
    unreachable)
  (func $_ZN5alloc3fmt6format12format_inner17hc76132f0eaf03496E (type 0) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 1
    i32.const 20
    i32.add
    i32.load
    local.set 3
    local.get 1
    i32.load
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.const 4
        i32.add
        i32.load
        local.tee 5
        i32.const 3
        i32.shl
        br_if 0 (;@2;)
        i32.const 0
        local.set 6
        br 1 (;@1;)
      end
      local.get 5
      i32.const -1
      i32.add
      i32.const 536870911
      i32.and
      local.tee 7
      i32.const 1
      i32.add
      local.tee 6
      i32.const 7
      i32.and
      local.set 8
      block  ;; label = @2
        block  ;; label = @3
          local.get 7
          i32.const 7
          i32.ge_u
          br_if 0 (;@3;)
          i32.const 0
          local.set 6
          local.get 4
          local.set 7
          br 1 (;@2;)
        end
        local.get 4
        i32.const 60
        i32.add
        local.set 7
        local.get 6
        i32.const 1073741816
        i32.and
        local.set 9
        i32.const 0
        local.set 6
        loop  ;; label = @3
          local.get 7
          i32.load
          local.get 7
          i32.const -8
          i32.add
          i32.load
          local.get 7
          i32.const -16
          i32.add
          i32.load
          local.get 7
          i32.const -24
          i32.add
          i32.load
          local.get 7
          i32.const -32
          i32.add
          i32.load
          local.get 7
          i32.const -40
          i32.add
          i32.load
          local.get 7
          i32.const -48
          i32.add
          i32.load
          local.get 7
          i32.const -56
          i32.add
          i32.load
          local.get 6
          i32.add
          i32.add
          i32.add
          i32.add
          i32.add
          i32.add
          i32.add
          i32.add
          local.set 6
          local.get 7
          i32.const 64
          i32.add
          local.set 7
          local.get 9
          i32.const -8
          i32.add
          local.tee 9
          br_if 0 (;@3;)
        end
        local.get 7
        i32.const -60
        i32.add
        local.set 7
      end
      local.get 8
      i32.eqz
      br_if 0 (;@1;)
      local.get 7
      i32.const 4
      i32.add
      local.set 7
      loop  ;; label = @2
        local.get 7
        i32.load
        local.get 6
        i32.add
        local.set 6
        local.get 7
        i32.const 8
        i32.add
        local.set 7
        local.get 8
        i32.const -1
        i32.add
        local.tee 8
        br_if 0 (;@2;)
      end
    end
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            br_if 0 (;@4;)
            local.get 6
            local.set 7
            br 1 (;@3;)
          end
          block  ;; label = @4
            local.get 5
            i32.eqz
            br_if 0 (;@4;)
            local.get 4
            i32.load offset=4
            br_if 0 (;@4;)
            local.get 6
            i32.const 16
            i32.lt_u
            br_if 2 (;@2;)
          end
          local.get 6
          local.get 6
          i32.add
          local.tee 7
          local.get 6
          i32.lt_u
          br_if 1 (;@2;)
        end
        local.get 7
        i32.eqz
        br_if 0 (;@2;)
        block  ;; label = @3
          block  ;; label = @4
            local.get 7
            i32.const -1
            i32.le_s
            br_if 0 (;@4;)
            local.get 7
            local.get 7
            i32.const -1
            i32.xor
            i32.const 31
            i32.shr_u
            local.tee 8
            call $__rust_alloc
            local.tee 6
            i32.eqz
            br_if 1 (;@3;)
            br 3 (;@1;)
          end
          call $_ZN5alloc7raw_vec17capacity_overflow17he8831a0490d21b13E
          unreachable
        end
        local.get 7
        local.get 8
        call $_ZN5alloc5alloc18handle_alloc_error17h42b2ac242981c6baE
        unreachable
      end
      i32.const 1
      local.set 6
      i32.const 0
      local.set 7
    end
    local.get 0
    i32.const 0
    i32.store offset=8
    local.get 0
    local.get 7
    i32.store offset=4
    local.get 0
    local.get 6
    i32.store
    local.get 2
    local.get 0
    i32.store offset=12
    local.get 2
    i32.const 16
    i32.add
    i32.const 16
    i32.add
    local.get 1
    i32.const 16
    i32.add
    i64.load align=4
    i64.store
    local.get 2
    i32.const 16
    i32.add
    i32.const 8
    i32.add
    local.get 1
    i32.const 8
    i32.add
    i64.load align=4
    i64.store
    local.get 2
    local.get 1
    i64.load align=4
    i64.store offset=16
    block  ;; label = @1
      local.get 2
      i32.const 12
      i32.add
      i32.const 1048892
      local.get 2
      i32.const 16
      i32.add
      call $_ZN4core3fmt5write17h62b20074abd80558E
      i32.eqz
      br_if 0 (;@1;)
      i32.const 1048988
      i32.const 51
      local.get 2
      i32.const 40
      i32.add
      i32.const 1049040
      i32.const 1049080
      call $_ZN4core6result13unwrap_failed17h04f89a0289aa4654E
      unreachable
    end
    local.get 2
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $_ZN4core3ops8function6FnOnce9call_once17ha601a3bcb64de8fcE (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    drop
    loop (result i32)  ;; label = @1
      br 0 (;@1;)
    end)
  (func $_ZN4core3ptr102drop_in_place$LT$$RF$core..iter..adapters..copied..Copied$LT$core..slice..iter..Iter$LT$u8$GT$$GT$$GT$17h7c59c825a74d7577E (type 3) (param i32))
  (func $_ZN4core9panicking9panic_fmt17h35029ccc4f395b26E (type 0) (param i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    i32.const 1
    i32.store8 offset=24
    local.get 2
    local.get 1
    i32.store offset=20
    local.get 2
    local.get 0
    i32.store offset=16
    local.get 2
    i32.const 1049096
    i32.store offset=12
    local.get 2
    i32.const 1049096
    i32.store offset=8
    local.get 2
    i32.const 8
    i32.add
    call $rust_begin_unwind
    unreachable)
  (func $_ZN4core3fmt9Formatter3pad17hc4faf2d8aff1ec8cE (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    local.get 0
    i32.load offset=16
    local.set 3
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.load offset=8
                local.tee 4
                i32.const 1
                i32.eq
                br_if 0 (;@6;)
                local.get 3
                i32.const 1
                i32.ne
                br_if 1 (;@5;)
              end
              local.get 3
              i32.const 1
              i32.ne
              br_if 3 (;@2;)
              local.get 1
              local.get 2
              i32.add
              local.set 5
              local.get 0
              i32.const 20
              i32.add
              i32.load
              local.tee 6
              br_if 1 (;@4;)
              i32.const 0
              local.set 7
              local.get 1
              local.set 8
              br 2 (;@3;)
            end
            local.get 0
            i32.load offset=24
            local.get 1
            local.get 2
            local.get 0
            i32.const 28
            i32.add
            i32.load
            i32.load offset=12
            call_indirect (type 1)
            local.set 3
            br 3 (;@1;)
          end
          i32.const 0
          local.set 7
          local.get 1
          local.set 8
          loop  ;; label = @4
            local.get 8
            local.tee 3
            local.get 5
            i32.eq
            br_if 2 (;@2;)
            block  ;; label = @5
              block  ;; label = @6
                local.get 3
                i32.load8_s
                local.tee 8
                i32.const -1
                i32.le_s
                br_if 0 (;@6;)
                local.get 3
                i32.const 1
                i32.add
                local.set 8
                br 1 (;@5;)
              end
              block  ;; label = @6
                local.get 8
                i32.const -32
                i32.ge_u
                br_if 0 (;@6;)
                local.get 3
                i32.const 2
                i32.add
                local.set 8
                br 1 (;@5;)
              end
              block  ;; label = @6
                local.get 8
                i32.const -16
                i32.ge_u
                br_if 0 (;@6;)
                local.get 3
                i32.const 3
                i32.add
                local.set 8
                br 1 (;@5;)
              end
              local.get 3
              i32.load8_u offset=2
              i32.const 63
              i32.and
              i32.const 6
              i32.shl
              local.get 3
              i32.load8_u offset=1
              i32.const 63
              i32.and
              i32.const 12
              i32.shl
              i32.or
              local.get 3
              i32.load8_u offset=3
              i32.const 63
              i32.and
              i32.or
              local.get 8
              i32.const 255
              i32.and
              i32.const 18
              i32.shl
              i32.const 1835008
              i32.and
              i32.or
              i32.const 1114112
              i32.eq
              br_if 3 (;@2;)
              local.get 3
              i32.const 4
              i32.add
              local.set 8
            end
            local.get 7
            local.get 3
            i32.sub
            local.get 8
            i32.add
            local.set 7
            local.get 6
            i32.const -1
            i32.add
            local.tee 6
            br_if 0 (;@4;)
          end
        end
        local.get 8
        local.get 5
        i32.eq
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 8
          i32.load8_s
          local.tee 3
          i32.const -1
          i32.gt_s
          br_if 0 (;@3;)
          local.get 3
          i32.const -32
          i32.lt_u
          br_if 0 (;@3;)
          local.get 3
          i32.const -16
          i32.lt_u
          br_if 0 (;@3;)
          local.get 8
          i32.load8_u offset=2
          i32.const 63
          i32.and
          i32.const 6
          i32.shl
          local.get 8
          i32.load8_u offset=1
          i32.const 63
          i32.and
          i32.const 12
          i32.shl
          i32.or
          local.get 8
          i32.load8_u offset=3
          i32.const 63
          i32.and
          i32.or
          local.get 3
          i32.const 255
          i32.and
          i32.const 18
          i32.shl
          i32.const 1835008
          i32.and
          i32.or
          i32.const 1114112
          i32.eq
          br_if 1 (;@2;)
        end
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 7
              br_if 0 (;@5;)
              i32.const 0
              local.set 8
              br 1 (;@4;)
            end
            block  ;; label = @5
              local.get 7
              local.get 2
              i32.lt_u
              br_if 0 (;@5;)
              i32.const 0
              local.set 3
              local.get 2
              local.set 8
              local.get 7
              local.get 2
              i32.eq
              br_if 1 (;@4;)
              br 2 (;@3;)
            end
            i32.const 0
            local.set 3
            local.get 7
            local.set 8
            local.get 1
            local.get 7
            i32.add
            i32.load8_s
            i32.const -64
            i32.lt_s
            br_if 1 (;@3;)
          end
          local.get 8
          local.set 7
          local.get 1
          local.set 3
        end
        local.get 7
        local.get 2
        local.get 3
        select
        local.set 2
        local.get 3
        local.get 1
        local.get 3
        select
        local.set 1
      end
      block  ;; label = @2
        local.get 4
        br_if 0 (;@2;)
        local.get 0
        i32.load offset=24
        local.get 1
        local.get 2
        local.get 0
        i32.const 28
        i32.add
        i32.load
        i32.load offset=12
        call_indirect (type 1)
        return
      end
      local.get 0
      i32.const 12
      i32.add
      i32.load
      local.set 5
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const 16
          i32.lt_u
          br_if 0 (;@3;)
          local.get 1
          local.get 2
          call $_ZN4core3str5count14do_count_chars17h129439cac6168cf3E
          local.set 8
          br 1 (;@2;)
        end
        block  ;; label = @3
          local.get 2
          br_if 0 (;@3;)
          i32.const 0
          local.set 8
          br 1 (;@2;)
        end
        local.get 2
        i32.const 3
        i32.and
        local.set 7
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.const -1
            i32.add
            i32.const 3
            i32.ge_u
            br_if 0 (;@4;)
            i32.const 0
            local.set 8
            local.get 1
            local.set 3
            br 1 (;@3;)
          end
          local.get 2
          i32.const -4
          i32.and
          local.set 6
          i32.const 0
          local.set 8
          local.get 1
          local.set 3
          loop  ;; label = @4
            local.get 8
            local.get 3
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 3
            i32.const 1
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 3
            i32.const 2
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 3
            i32.const 3
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.set 8
            local.get 3
            i32.const 4
            i32.add
            local.set 3
            local.get 6
            i32.const -4
            i32.add
            local.tee 6
            br_if 0 (;@4;)
          end
        end
        local.get 7
        i32.eqz
        br_if 0 (;@2;)
        loop  ;; label = @3
          local.get 8
          local.get 3
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.set 8
          local.get 3
          i32.const 1
          i32.add
          local.set 3
          local.get 7
          i32.const -1
          i32.add
          local.tee 7
          br_if 0 (;@3;)
        end
      end
      block  ;; label = @2
        local.get 5
        local.get 8
        i32.le_u
        br_if 0 (;@2;)
        i32.const 0
        local.set 3
        local.get 5
        local.get 8
        i32.sub
        local.tee 7
        local.set 6
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              i32.const 0
              local.get 0
              i32.load8_u offset=32
              local.tee 8
              local.get 8
              i32.const 3
              i32.eq
              select
              i32.const 3
              i32.and
              br_table 2 (;@3;) 0 (;@5;) 1 (;@4;) 2 (;@3;)
            end
            i32.const 0
            local.set 6
            local.get 7
            local.set 3
            br 1 (;@3;)
          end
          local.get 7
          i32.const 1
          i32.shr_u
          local.set 3
          local.get 7
          i32.const 1
          i32.add
          i32.const 1
          i32.shr_u
          local.set 6
        end
        local.get 3
        i32.const 1
        i32.add
        local.set 3
        local.get 0
        i32.const 28
        i32.add
        i32.load
        local.set 7
        local.get 0
        i32.load offset=4
        local.set 8
        local.get 0
        i32.load offset=24
        local.set 0
        block  ;; label = @3
          loop  ;; label = @4
            local.get 3
            i32.const -1
            i32.add
            local.tee 3
            i32.eqz
            br_if 1 (;@3;)
            local.get 0
            local.get 8
            local.get 7
            i32.load offset=16
            call_indirect (type 2)
            i32.eqz
            br_if 0 (;@4;)
          end
          i32.const 1
          return
        end
        i32.const 1
        local.set 3
        local.get 8
        i32.const 1114112
        i32.eq
        br_if 1 (;@1;)
        local.get 0
        local.get 1
        local.get 2
        local.get 7
        i32.load offset=12
        call_indirect (type 1)
        br_if 1 (;@1;)
        i32.const 0
        local.set 3
        loop  ;; label = @3
          block  ;; label = @4
            local.get 6
            local.get 3
            i32.ne
            br_if 0 (;@4;)
            local.get 6
            local.get 6
            i32.lt_u
            return
          end
          local.get 3
          i32.const 1
          i32.add
          local.set 3
          local.get 0
          local.get 8
          local.get 7
          i32.load offset=16
          call_indirect (type 2)
          i32.eqz
          br_if 0 (;@3;)
        end
        local.get 3
        i32.const -1
        i32.add
        local.get 6
        i32.lt_u
        return
      end
      local.get 0
      i32.load offset=24
      local.get 1
      local.get 2
      local.get 0
      i32.const 28
      i32.add
      i32.load
      i32.load offset=12
      call_indirect (type 1)
      return
    end
    local.get 3)
  (func $_ZN4core9panicking5panic17ha4be2267b4d7eb1bE (type 6) (param i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    i32.const 20
    i32.add
    i32.const 0
    i32.store
    local.get 3
    i32.const 1049096
    i32.store offset=16
    local.get 3
    i64.const 1
    i64.store offset=4 align=4
    local.get 3
    local.get 1
    i32.store offset=28
    local.get 3
    local.get 0
    i32.store offset=24
    local.get 3
    local.get 3
    i32.const 24
    i32.add
    i32.store
    local.get 3
    local.get 2
    call $_ZN4core9panicking9panic_fmt17h35029ccc4f395b26E
    unreachable)
  (func $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h14744b2f90deaafdE (type 2) (param i32 i32) (result i32)
    local.get 0
    i64.load32_u
    i32.const 1
    local.get 1
    call $_ZN4core3fmt3num3imp7fmt_u6417h26a2989f9c581a37E)
  (func $_ZN4core3fmt5write17h62b20074abd80558E (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    i32.const 36
    i32.add
    local.get 1
    i32.store
    local.get 3
    i32.const 3
    i32.store8 offset=40
    local.get 3
    i64.const 137438953472
    i64.store offset=8
    local.get 3
    local.get 0
    i32.store offset=32
    i32.const 0
    local.set 4
    local.get 3
    i32.const 0
    i32.store offset=24
    local.get 3
    i32.const 0
    i32.store offset=16
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.load offset=8
            local.tee 5
            br_if 0 (;@4;)
            local.get 2
            i32.const 20
            i32.add
            i32.load
            local.tee 6
            i32.eqz
            br_if 1 (;@3;)
            local.get 2
            i32.load
            local.set 1
            local.get 2
            i32.load offset=16
            local.set 0
            local.get 6
            i32.const -1
            i32.add
            i32.const 536870911
            i32.and
            i32.const 1
            i32.add
            local.tee 4
            local.set 6
            loop  ;; label = @5
              block  ;; label = @6
                local.get 1
                i32.const 4
                i32.add
                i32.load
                local.tee 7
                i32.eqz
                br_if 0 (;@6;)
                local.get 3
                i32.load offset=32
                local.get 1
                i32.load
                local.get 7
                local.get 3
                i32.load offset=36
                i32.load offset=12
                call_indirect (type 1)
                br_if 4 (;@2;)
              end
              local.get 0
              i32.load
              local.get 3
              i32.const 8
              i32.add
              local.get 0
              i32.const 4
              i32.add
              i32.load
              call_indirect (type 2)
              br_if 3 (;@2;)
              local.get 0
              i32.const 8
              i32.add
              local.set 0
              local.get 1
              i32.const 8
              i32.add
              local.set 1
              local.get 6
              i32.const -1
              i32.add
              local.tee 6
              br_if 0 (;@5;)
              br 2 (;@3;)
            end
          end
          local.get 2
          i32.const 12
          i32.add
          i32.load
          local.tee 0
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          i32.const 5
          i32.shl
          local.set 8
          local.get 0
          i32.const -1
          i32.add
          i32.const 134217727
          i32.and
          i32.const 1
          i32.add
          local.set 4
          local.get 2
          i32.load
          local.set 1
          i32.const 0
          local.set 6
          loop  ;; label = @4
            block  ;; label = @5
              local.get 1
              i32.const 4
              i32.add
              i32.load
              local.tee 0
              i32.eqz
              br_if 0 (;@5;)
              local.get 3
              i32.load offset=32
              local.get 1
              i32.load
              local.get 0
              local.get 3
              i32.load offset=36
              i32.load offset=12
              call_indirect (type 1)
              br_if 3 (;@2;)
            end
            local.get 3
            local.get 5
            local.get 6
            i32.add
            local.tee 0
            i32.const 28
            i32.add
            i32.load8_u
            i32.store8 offset=40
            local.get 3
            local.get 0
            i32.const 4
            i32.add
            i64.load align=4
            i64.const 32
            i64.rotl
            i64.store offset=8
            local.get 0
            i32.const 24
            i32.add
            i32.load
            local.set 9
            local.get 2
            i32.load offset=16
            local.set 10
            i32.const 0
            local.set 11
            i32.const 0
            local.set 7
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 0
                  i32.const 20
                  i32.add
                  i32.load
                  br_table 1 (;@6;) 0 (;@7;) 2 (;@5;) 1 (;@6;)
                end
                local.get 9
                i32.const 3
                i32.shl
                local.set 12
                i32.const 0
                local.set 7
                local.get 10
                local.get 12
                i32.add
                local.tee 12
                i32.load offset=4
                i32.const 21
                i32.ne
                br_if 1 (;@5;)
                local.get 12
                i32.load
                i32.load
                local.set 9
              end
              i32.const 1
              local.set 7
            end
            local.get 3
            local.get 9
            i32.store offset=20
            local.get 3
            local.get 7
            i32.store offset=16
            local.get 0
            i32.const 16
            i32.add
            i32.load
            local.set 7
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 0
                  i32.const 12
                  i32.add
                  i32.load
                  br_table 1 (;@6;) 0 (;@7;) 2 (;@5;) 1 (;@6;)
                end
                local.get 7
                i32.const 3
                i32.shl
                local.set 9
                local.get 10
                local.get 9
                i32.add
                local.tee 9
                i32.load offset=4
                i32.const 21
                i32.ne
                br_if 1 (;@5;)
                local.get 9
                i32.load
                i32.load
                local.set 7
              end
              i32.const 1
              local.set 11
            end
            local.get 3
            local.get 7
            i32.store offset=28
            local.get 3
            local.get 11
            i32.store offset=24
            local.get 10
            local.get 0
            i32.load
            i32.const 3
            i32.shl
            i32.add
            local.tee 0
            i32.load
            local.get 3
            i32.const 8
            i32.add
            local.get 0
            i32.load offset=4
            call_indirect (type 2)
            br_if 2 (;@2;)
            local.get 1
            i32.const 8
            i32.add
            local.set 1
            local.get 8
            local.get 6
            i32.const 32
            i32.add
            local.tee 6
            i32.ne
            br_if 0 (;@4;)
          end
        end
        i32.const 0
        local.set 0
        local.get 4
        local.get 2
        i32.load offset=4
        i32.lt_u
        local.tee 1
        i32.eqz
        br_if 1 (;@1;)
        local.get 3
        i32.load offset=32
        local.get 2
        i32.load
        local.get 4
        i32.const 3
        i32.shl
        i32.add
        i32.const 0
        local.get 1
        select
        local.tee 1
        i32.load
        local.get 1
        i32.load offset=4
        local.get 3
        i32.load offset=36
        i32.load offset=12
        call_indirect (type 1)
        i32.eqz
        br_if 1 (;@1;)
      end
      i32.const 1
      local.set 0
    end
    local.get 3
    i32.const 48
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h26da887aa8291663E (type 9) (param i32) (result i64)
    i64.const -1169006945178785205)
  (func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hd053ae06518d545bE (type 2) (param i32 i32) (result i32)
    local.get 1
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    call $_ZN4core3fmt9Formatter3pad17hc4faf2d8aff1ec8cE)
  (func $_ZN4core5panic10panic_info9PanicInfo7message17he101928971688e3bE (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=8)
  (func $_ZN4core5panic10panic_info9PanicInfo8location17h63e6170dfebcfc8aE (type 4) (param i32) (result i32)
    local.get 0
    i32.load offset=12)
  (func $_ZN4core5panic10panic_info9PanicInfo10can_unwind17h053b4173296e76faE (type 4) (param i32) (result i32)
    local.get 0
    i32.load8_u offset=16)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h7de26306900648efE (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    local.get 0
    i32.load offset=4
    i32.load offset=12
    call_indirect (type 2))
  (func $_ZN4core6result13unwrap_failed17h04f89a0289aa4654E (type 11) (param i32 i32 i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 64
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    local.get 5
    local.get 1
    i32.store offset=12
    local.get 5
    local.get 0
    i32.store offset=8
    local.get 5
    local.get 3
    i32.store offset=20
    local.get 5
    local.get 2
    i32.store offset=16
    local.get 5
    i32.const 44
    i32.add
    i32.const 2
    i32.store
    local.get 5
    i32.const 60
    i32.add
    i32.const 22
    i32.store
    local.get 5
    i64.const 2
    i64.store offset=28 align=4
    local.get 5
    i32.const 1049116
    i32.store offset=24
    local.get 5
    i32.const 23
    i32.store offset=52
    local.get 5
    local.get 5
    i32.const 48
    i32.add
    i32.store offset=40
    local.get 5
    local.get 5
    i32.const 16
    i32.add
    i32.store offset=56
    local.get 5
    local.get 5
    i32.const 8
    i32.add
    i32.store offset=48
    local.get 5
    i32.const 24
    i32.add
    local.get 4
    call $_ZN4core9panicking9panic_fmt17h35029ccc4f395b26E
    unreachable)
  (func $_ZN4core3fmt9Formatter12pad_integral17h0869937c6d088fe8E (type 13) (param i32 i32 i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.eqz
        br_if 0 (;@2;)
        i32.const 43
        i32.const 1114112
        local.get 0
        i32.load
        local.tee 1
        i32.const 1
        i32.and
        local.tee 6
        select
        local.set 7
        local.get 6
        local.get 5
        i32.add
        local.set 8
        br 1 (;@1;)
      end
      local.get 5
      i32.const 1
      i32.add
      local.set 8
      local.get 0
      i32.load
      local.set 1
      i32.const 45
      local.set 7
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.const 4
        i32.and
        br_if 0 (;@2;)
        i32.const 0
        local.set 2
        br 1 (;@1;)
      end
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.const 16
          i32.lt_u
          br_if 0 (;@3;)
          local.get 2
          local.get 3
          call $_ZN4core3str5count14do_count_chars17h129439cac6168cf3E
          local.set 6
          br 1 (;@2;)
        end
        block  ;; label = @3
          local.get 3
          br_if 0 (;@3;)
          i32.const 0
          local.set 6
          br 1 (;@2;)
        end
        local.get 3
        i32.const 3
        i32.and
        local.set 9
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            i32.const -1
            i32.add
            i32.const 3
            i32.ge_u
            br_if 0 (;@4;)
            i32.const 0
            local.set 6
            local.get 2
            local.set 1
            br 1 (;@3;)
          end
          local.get 3
          i32.const -4
          i32.and
          local.set 10
          i32.const 0
          local.set 6
          local.get 2
          local.set 1
          loop  ;; label = @4
            local.get 6
            local.get 1
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 1
            i32.const 1
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 1
            i32.const 2
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 1
            i32.const 3
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.set 6
            local.get 1
            i32.const 4
            i32.add
            local.set 1
            local.get 10
            i32.const -4
            i32.add
            local.tee 10
            br_if 0 (;@4;)
          end
        end
        local.get 9
        i32.eqz
        br_if 0 (;@2;)
        loop  ;; label = @3
          local.get 6
          local.get 1
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.set 6
          local.get 1
          i32.const 1
          i32.add
          local.set 1
          local.get 9
          i32.const -1
          i32.add
          local.tee 9
          br_if 0 (;@3;)
        end
      end
      local.get 6
      local.get 8
      i32.add
      local.set 8
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load offset=8
        br_if 0 (;@2;)
        i32.const 1
        local.set 1
        local.get 0
        local.get 7
        local.get 2
        local.get 3
        call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h3fbb5524352cea6bE
        br_if 1 (;@1;)
        local.get 0
        i32.load offset=24
        local.get 4
        local.get 5
        local.get 0
        i32.const 28
        i32.add
        i32.load
        i32.load offset=12
        call_indirect (type 1)
        return
      end
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.const 12
                i32.add
                i32.load
                local.tee 6
                local.get 8
                i32.le_u
                br_if 0 (;@6;)
                local.get 0
                i32.load8_u
                i32.const 8
                i32.and
                br_if 4 (;@2;)
                i32.const 0
                local.set 1
                local.get 6
                local.get 8
                i32.sub
                local.tee 9
                local.set 8
                i32.const 1
                local.get 0
                i32.load8_u offset=32
                local.tee 6
                local.get 6
                i32.const 3
                i32.eq
                select
                i32.const 3
                i32.and
                br_table 3 (;@3;) 1 (;@5;) 2 (;@4;) 3 (;@3;)
              end
              i32.const 1
              local.set 1
              local.get 0
              local.get 7
              local.get 2
              local.get 3
              call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h3fbb5524352cea6bE
              br_if 4 (;@1;)
              local.get 0
              i32.load offset=24
              local.get 4
              local.get 5
              local.get 0
              i32.const 28
              i32.add
              i32.load
              i32.load offset=12
              call_indirect (type 1)
              return
            end
            i32.const 0
            local.set 8
            local.get 9
            local.set 1
            br 1 (;@3;)
          end
          local.get 9
          i32.const 1
          i32.shr_u
          local.set 1
          local.get 9
          i32.const 1
          i32.add
          i32.const 1
          i32.shr_u
          local.set 8
        end
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        local.get 0
        i32.const 28
        i32.add
        i32.load
        local.set 9
        local.get 0
        i32.load offset=4
        local.set 6
        local.get 0
        i32.load offset=24
        local.set 10
        block  ;; label = @3
          loop  ;; label = @4
            local.get 1
            i32.const -1
            i32.add
            local.tee 1
            i32.eqz
            br_if 1 (;@3;)
            local.get 10
            local.get 6
            local.get 9
            i32.load offset=16
            call_indirect (type 2)
            i32.eqz
            br_if 0 (;@4;)
          end
          i32.const 1
          return
        end
        i32.const 1
        local.set 1
        local.get 6
        i32.const 1114112
        i32.eq
        br_if 1 (;@1;)
        local.get 0
        local.get 7
        local.get 2
        local.get 3
        call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h3fbb5524352cea6bE
        br_if 1 (;@1;)
        local.get 0
        i32.load offset=24
        local.get 4
        local.get 5
        local.get 0
        i32.load offset=28
        i32.load offset=12
        call_indirect (type 1)
        br_if 1 (;@1;)
        local.get 0
        i32.load offset=28
        local.set 9
        local.get 0
        i32.load offset=24
        local.set 0
        i32.const 0
        local.set 1
        block  ;; label = @3
          loop  ;; label = @4
            block  ;; label = @5
              local.get 8
              local.get 1
              i32.ne
              br_if 0 (;@5;)
              local.get 8
              local.set 1
              br 2 (;@3;)
            end
            local.get 1
            i32.const 1
            i32.add
            local.set 1
            local.get 0
            local.get 6
            local.get 9
            i32.load offset=16
            call_indirect (type 2)
            i32.eqz
            br_if 0 (;@4;)
          end
          local.get 1
          i32.const -1
          i32.add
          local.set 1
        end
        local.get 1
        local.get 8
        i32.lt_u
        local.set 1
        br 1 (;@1;)
      end
      local.get 0
      i32.load offset=4
      local.set 11
      local.get 0
      i32.const 48
      i32.store offset=4
      local.get 0
      i32.load8_u offset=32
      local.set 12
      i32.const 1
      local.set 1
      local.get 0
      i32.const 1
      i32.store8 offset=32
      local.get 0
      local.get 7
      local.get 2
      local.get 3
      call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h3fbb5524352cea6bE
      br_if 0 (;@1;)
      i32.const 0
      local.set 1
      local.get 6
      local.get 8
      i32.sub
      local.tee 9
      local.set 3
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            i32.const 1
            local.get 0
            i32.load8_u offset=32
            local.tee 6
            local.get 6
            i32.const 3
            i32.eq
            select
            i32.const 3
            i32.and
            br_table 2 (;@2;) 0 (;@4;) 1 (;@3;) 2 (;@2;)
          end
          i32.const 0
          local.set 3
          local.get 9
          local.set 1
          br 1 (;@2;)
        end
        local.get 9
        i32.const 1
        i32.shr_u
        local.set 1
        local.get 9
        i32.const 1
        i32.add
        i32.const 1
        i32.shr_u
        local.set 3
      end
      local.get 1
      i32.const 1
      i32.add
      local.set 1
      local.get 0
      i32.const 28
      i32.add
      i32.load
      local.set 9
      local.get 0
      i32.load offset=4
      local.set 6
      local.get 0
      i32.load offset=24
      local.set 10
      block  ;; label = @2
        loop  ;; label = @3
          local.get 1
          i32.const -1
          i32.add
          local.tee 1
          i32.eqz
          br_if 1 (;@2;)
          local.get 10
          local.get 6
          local.get 9
          i32.load offset=16
          call_indirect (type 2)
          i32.eqz
          br_if 0 (;@3;)
        end
        i32.const 1
        return
      end
      i32.const 1
      local.set 1
      local.get 6
      i32.const 1114112
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      i32.load offset=24
      local.get 4
      local.get 5
      local.get 0
      i32.load offset=28
      i32.load offset=12
      call_indirect (type 1)
      br_if 0 (;@1;)
      local.get 0
      i32.load offset=28
      local.set 1
      local.get 0
      i32.load offset=24
      local.set 10
      i32.const 0
      local.set 9
      block  ;; label = @2
        loop  ;; label = @3
          local.get 3
          local.get 9
          i32.eq
          br_if 1 (;@2;)
          local.get 9
          i32.const 1
          i32.add
          local.set 9
          local.get 10
          local.get 6
          local.get 1
          i32.load offset=16
          call_indirect (type 2)
          i32.eqz
          br_if 0 (;@3;)
        end
        i32.const 1
        local.set 1
        local.get 9
        i32.const -1
        i32.add
        local.get 3
        i32.lt_u
        br_if 1 (;@1;)
      end
      local.get 0
      local.get 12
      i32.store8 offset=32
      local.get 0
      local.get 11
      i32.store offset=4
      i32.const 0
      return
    end
    local.get 1)
  (func $_ZN4core3str5count14do_count_chars17h129439cac6168cf3E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 3
        i32.add
        i32.const -4
        i32.and
        local.tee 2
        local.get 0
        i32.sub
        local.tee 3
        local.get 1
        i32.gt_u
        br_if 0 (;@2;)
        local.get 3
        i32.const 4
        i32.gt_u
        br_if 0 (;@2;)
        local.get 1
        local.get 3
        i32.sub
        local.tee 4
        i32.const 4
        i32.lt_u
        br_if 0 (;@2;)
        local.get 4
        i32.const 3
        i32.and
        local.set 5
        i32.const 0
        local.set 6
        i32.const 0
        local.set 1
        block  ;; label = @3
          local.get 3
          i32.eqz
          br_if 0 (;@3;)
          local.get 3
          i32.const 3
          i32.and
          local.set 7
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              local.get 0
              i32.const -1
              i32.xor
              i32.add
              i32.const 3
              i32.ge_u
              br_if 0 (;@5;)
              i32.const 0
              local.set 1
              local.get 0
              local.set 2
              br 1 (;@4;)
            end
            local.get 3
            i32.const -4
            i32.and
            local.set 8
            i32.const 0
            local.set 1
            local.get 0
            local.set 2
            loop  ;; label = @5
              local.get 1
              local.get 2
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 2
              i32.const 1
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 2
              i32.const 2
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 2
              i32.const 3
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.set 1
              local.get 2
              i32.const 4
              i32.add
              local.set 2
              local.get 8
              i32.const -4
              i32.add
              local.tee 8
              br_if 0 (;@5;)
            end
          end
          local.get 7
          i32.eqz
          br_if 0 (;@3;)
          loop  ;; label = @4
            local.get 1
            local.get 2
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.set 1
            local.get 2
            i32.const 1
            i32.add
            local.set 2
            local.get 7
            i32.const -1
            i32.add
            local.tee 7
            br_if 0 (;@4;)
          end
        end
        local.get 0
        local.get 3
        i32.add
        local.set 0
        block  ;; label = @3
          local.get 5
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 4
          i32.const -4
          i32.and
          i32.add
          local.tee 2
          i32.load8_s
          i32.const -65
          i32.gt_s
          local.set 6
          local.get 5
          i32.const 1
          i32.eq
          br_if 0 (;@3;)
          local.get 6
          local.get 2
          i32.load8_s offset=1
          i32.const -65
          i32.gt_s
          i32.add
          local.set 6
          local.get 5
          i32.const 2
          i32.eq
          br_if 0 (;@3;)
          local.get 6
          local.get 2
          i32.load8_s offset=2
          i32.const -65
          i32.gt_s
          i32.add
          local.set 6
        end
        local.get 4
        i32.const 2
        i32.shr_u
        local.set 3
        local.get 6
        local.get 1
        i32.add
        local.set 8
        loop  ;; label = @3
          local.get 0
          local.set 6
          local.get 3
          i32.eqz
          br_if 2 (;@1;)
          local.get 3
          i32.const 192
          local.get 3
          i32.const 192
          i32.lt_u
          select
          local.tee 4
          i32.const 3
          i32.and
          local.set 5
          local.get 4
          i32.const 2
          i32.shl
          local.set 9
          block  ;; label = @4
            block  ;; label = @5
              local.get 4
              i32.const 252
              i32.and
              local.tee 10
              i32.const 2
              i32.shl
              local.tee 0
              br_if 0 (;@5;)
              i32.const 0
              local.set 2
              br 1 (;@4;)
            end
            local.get 6
            local.get 0
            i32.add
            local.set 7
            i32.const 0
            local.set 2
            local.get 6
            local.set 0
            loop  ;; label = @5
              local.get 0
              i32.const 12
              i32.add
              i32.load
              local.tee 1
              i32.const -1
              i32.xor
              i32.const 7
              i32.shr_u
              local.get 1
              i32.const 6
              i32.shr_u
              i32.or
              i32.const 16843009
              i32.and
              local.get 0
              i32.const 8
              i32.add
              i32.load
              local.tee 1
              i32.const -1
              i32.xor
              i32.const 7
              i32.shr_u
              local.get 1
              i32.const 6
              i32.shr_u
              i32.or
              i32.const 16843009
              i32.and
              local.get 0
              i32.const 4
              i32.add
              i32.load
              local.tee 1
              i32.const -1
              i32.xor
              i32.const 7
              i32.shr_u
              local.get 1
              i32.const 6
              i32.shr_u
              i32.or
              i32.const 16843009
              i32.and
              local.get 0
              i32.load
              local.tee 1
              i32.const -1
              i32.xor
              i32.const 7
              i32.shr_u
              local.get 1
              i32.const 6
              i32.shr_u
              i32.or
              i32.const 16843009
              i32.and
              local.get 2
              i32.add
              i32.add
              i32.add
              i32.add
              local.set 2
              local.get 7
              local.get 0
              i32.const 16
              i32.add
              local.tee 0
              i32.ne
              br_if 0 (;@5;)
            end
          end
          local.get 6
          local.get 9
          i32.add
          local.set 0
          local.get 3
          local.get 4
          i32.sub
          local.set 3
          local.get 2
          i32.const 8
          i32.shr_u
          i32.const 16711935
          i32.and
          local.get 2
          i32.const 16711935
          i32.and
          i32.add
          i32.const 65537
          i32.mul
          i32.const 16
          i32.shr_u
          local.get 8
          i32.add
          local.set 8
          local.get 5
          i32.eqz
          br_if 0 (;@3;)
        end
        local.get 6
        local.get 10
        i32.const 2
        i32.shl
        i32.add
        local.set 0
        local.get 5
        i32.const 1073741823
        i32.add
        local.tee 4
        i32.const 1073741823
        i32.and
        local.tee 2
        i32.const 1
        i32.add
        local.tee 1
        i32.const 3
        i32.and
        local.set 3
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.const 3
            i32.ge_u
            br_if 0 (;@4;)
            i32.const 0
            local.set 2
            br 1 (;@3;)
          end
          local.get 1
          i32.const 2147483644
          i32.and
          local.set 1
          i32.const 0
          local.set 2
          loop  ;; label = @4
            local.get 0
            i32.const 12
            i32.add
            i32.load
            local.tee 7
            i32.const -1
            i32.xor
            i32.const 7
            i32.shr_u
            local.get 7
            i32.const 6
            i32.shr_u
            i32.or
            i32.const 16843009
            i32.and
            local.get 0
            i32.const 8
            i32.add
            i32.load
            local.tee 7
            i32.const -1
            i32.xor
            i32.const 7
            i32.shr_u
            local.get 7
            i32.const 6
            i32.shr_u
            i32.or
            i32.const 16843009
            i32.and
            local.get 0
            i32.const 4
            i32.add
            i32.load
            local.tee 7
            i32.const -1
            i32.xor
            i32.const 7
            i32.shr_u
            local.get 7
            i32.const 6
            i32.shr_u
            i32.or
            i32.const 16843009
            i32.and
            local.get 0
            i32.load
            local.tee 7
            i32.const -1
            i32.xor
            i32.const 7
            i32.shr_u
            local.get 7
            i32.const 6
            i32.shr_u
            i32.or
            i32.const 16843009
            i32.and
            local.get 2
            i32.add
            i32.add
            i32.add
            i32.add
            local.set 2
            local.get 0
            i32.const 16
            i32.add
            local.set 0
            local.get 1
            i32.const -4
            i32.add
            local.tee 1
            br_if 0 (;@4;)
          end
        end
        block  ;; label = @3
          local.get 3
          i32.eqz
          br_if 0 (;@3;)
          local.get 4
          i32.const -1073741823
          i32.add
          local.set 1
          loop  ;; label = @4
            local.get 0
            i32.load
            local.tee 7
            i32.const -1
            i32.xor
            i32.const 7
            i32.shr_u
            local.get 7
            i32.const 6
            i32.shr_u
            i32.or
            i32.const 16843009
            i32.and
            local.get 2
            i32.add
            local.set 2
            local.get 0
            i32.const 4
            i32.add
            local.set 0
            local.get 1
            i32.const -1
            i32.add
            local.tee 1
            br_if 0 (;@4;)
          end
        end
        local.get 2
        i32.const 8
        i32.shr_u
        i32.const 16711935
        i32.and
        local.get 2
        i32.const 16711935
        i32.and
        i32.add
        i32.const 65537
        i32.mul
        i32.const 16
        i32.shr_u
        local.get 8
        i32.add
        return
      end
      block  ;; label = @2
        local.get 1
        br_if 0 (;@2;)
        i32.const 0
        return
      end
      local.get 1
      i32.const 3
      i32.and
      local.set 2
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.const -1
          i32.add
          i32.const 3
          i32.ge_u
          br_if 0 (;@3;)
          i32.const 0
          local.set 8
          br 1 (;@2;)
        end
        local.get 1
        i32.const -4
        i32.and
        local.set 1
        i32.const 0
        local.set 8
        loop  ;; label = @3
          local.get 8
          local.get 0
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.get 0
          i32.const 1
          i32.add
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.get 0
          i32.const 2
          i32.add
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.get 0
          i32.const 3
          i32.add
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.set 8
          local.get 0
          i32.const 4
          i32.add
          local.set 0
          local.get 1
          i32.const -4
          i32.add
          local.tee 1
          br_if 0 (;@3;)
        end
      end
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      loop  ;; label = @2
        local.get 8
        local.get 0
        i32.load8_s
        i32.const -65
        i32.gt_s
        i32.add
        local.set 8
        local.get 0
        i32.const 1
        i32.add
        local.set 0
        local.get 2
        i32.const -1
        i32.add
        local.tee 2
        br_if 0 (;@2;)
      end
    end
    local.get 8)
  (func $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h3fbb5524352cea6bE (type 7) (param i32 i32 i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.const 1114112
          i32.eq
          br_if 0 (;@3;)
          i32.const 1
          local.set 4
          local.get 0
          i32.load offset=24
          local.get 1
          local.get 0
          i32.const 28
          i32.add
          i32.load
          i32.load offset=16
          call_indirect (type 2)
          br_if 1 (;@2;)
        end
        local.get 2
        br_if 1 (;@1;)
        i32.const 0
        local.set 4
      end
      local.get 4
      return
    end
    local.get 0
    i32.load offset=24
    local.get 2
    local.get 3
    local.get 0
    i32.const 28
    i32.add
    i32.load
    i32.load offset=12
    call_indirect (type 1))
  (func $_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h90ba1b7a9eb08159E (type 1) (param i32 i32 i32) (result i32)
    local.get 2
    local.get 0
    local.get 1
    call $_ZN4core3fmt9Formatter3pad17hc4faf2d8aff1ec8cE)
  (func $_ZN4core3fmt3num3imp7fmt_u6417h26a2989f9c581a37E (type 14) (param i64 i32 i32) (result i32)
    (local i32 i32 i64 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    i32.const 39
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i64.const 10000
        i64.ge_u
        br_if 0 (;@2;)
        local.get 0
        local.set 5
        br 1 (;@1;)
      end
      i32.const 39
      local.set 4
      loop  ;; label = @2
        local.get 3
        i32.const 9
        i32.add
        local.get 4
        i32.add
        local.tee 6
        i32.const -4
        i32.add
        local.get 0
        local.get 0
        i64.const 10000
        i64.div_u
        local.tee 5
        i64.const 10000
        i64.mul
        i64.sub
        i32.wrap_i64
        local.tee 7
        i32.const 65535
        i32.and
        i32.const 100
        i32.div_u
        local.tee 8
        i32.const 1
        i32.shl
        i32.const 1049132
        i32.add
        i32.load16_u align=1
        i32.store16 align=1
        local.get 6
        i32.const -2
        i32.add
        local.get 7
        local.get 8
        i32.const 100
        i32.mul
        i32.sub
        i32.const 65535
        i32.and
        i32.const 1
        i32.shl
        i32.const 1049132
        i32.add
        i32.load16_u align=1
        i32.store16 align=1
        local.get 4
        i32.const -4
        i32.add
        local.set 4
        local.get 0
        i64.const 99999999
        i64.gt_u
        local.set 6
        local.get 5
        local.set 0
        local.get 6
        br_if 0 (;@2;)
      end
    end
    block  ;; label = @1
      local.get 5
      i32.wrap_i64
      local.tee 6
      i32.const 99
      i32.le_u
      br_if 0 (;@1;)
      local.get 3
      i32.const 9
      i32.add
      local.get 4
      i32.const -2
      i32.add
      local.tee 4
      i32.add
      local.get 5
      i32.wrap_i64
      local.tee 6
      local.get 6
      i32.const 65535
      i32.and
      i32.const 100
      i32.div_u
      local.tee 6
      i32.const 100
      i32.mul
      i32.sub
      i32.const 65535
      i32.and
      i32.const 1
      i32.shl
      i32.const 1049132
      i32.add
      i32.load16_u align=1
      i32.store16 align=1
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 6
        i32.const 10
        i32.lt_u
        br_if 0 (;@2;)
        local.get 3
        i32.const 9
        i32.add
        local.get 4
        i32.const -2
        i32.add
        local.tee 4
        i32.add
        local.get 6
        i32.const 1
        i32.shl
        i32.const 1049132
        i32.add
        i32.load16_u align=1
        i32.store16 align=1
        br 1 (;@1;)
      end
      local.get 3
      i32.const 9
      i32.add
      local.get 4
      i32.const -1
      i32.add
      local.tee 4
      i32.add
      local.get 6
      i32.const 48
      i32.add
      i32.store8
    end
    local.get 2
    local.get 1
    i32.const 1049096
    i32.const 0
    local.get 3
    i32.const 9
    i32.add
    local.get 4
    i32.add
    i32.const 39
    local.get 4
    i32.sub
    call $_ZN4core3fmt9Formatter12pad_integral17h0869937c6d088fe8E
    local.set 4
    local.get 3
    i32.const 48
    i32.add
    global.set $__stack_pointer
    local.get 4)
  (func $_ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h5720878ff189bd51E (type 2) (param i32 i32) (result i32)
    local.get 1
    i32.load offset=24
    i32.const 1049332
    i32.const 5
    local.get 1
    i32.const 28
    i32.add
    i32.load
    i32.load offset=12
    call_indirect (type 1))
  (func $memcpy (type 1) (param i32 i32 i32) (result i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN17compiler_builtins3mem6memcpy17h7097b81567cf1b82E)
  (func $_ZN17compiler_builtins3mem6memcpy17h7097b81567cf1b82E (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const 15
        i32.gt_u
        br_if 0 (;@2;)
        local.get 0
        local.set 3
        br 1 (;@1;)
      end
      local.get 0
      i32.const 0
      local.get 0
      i32.sub
      i32.const 3
      i32.and
      local.tee 4
      i32.add
      local.set 5
      block  ;; label = @2
        local.get 4
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        local.set 3
        local.get 1
        local.set 6
        loop  ;; label = @3
          local.get 3
          local.get 6
          i32.load8_u
          i32.store8
          local.get 6
          i32.const 1
          i32.add
          local.set 6
          local.get 3
          i32.const 1
          i32.add
          local.tee 3
          local.get 5
          i32.lt_u
          br_if 0 (;@3;)
        end
      end
      local.get 5
      local.get 2
      local.get 4
      i32.sub
      local.tee 7
      i32.const -4
      i32.and
      local.tee 8
      i32.add
      local.set 3
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          local.get 4
          i32.add
          local.tee 9
          i32.const 3
          i32.and
          local.tee 6
          i32.eqz
          br_if 0 (;@3;)
          local.get 8
          i32.const 1
          i32.lt_s
          br_if 1 (;@2;)
          local.get 9
          i32.const -4
          i32.and
          local.tee 10
          i32.const 4
          i32.add
          local.set 1
          i32.const 0
          local.get 6
          i32.const 3
          i32.shl
          local.tee 2
          i32.sub
          i32.const 24
          i32.and
          local.set 4
          local.get 10
          i32.load
          local.set 6
          loop  ;; label = @4
            local.get 5
            local.get 6
            local.get 2
            i32.shr_u
            local.get 1
            i32.load
            local.tee 6
            local.get 4
            i32.shl
            i32.or
            i32.store
            local.get 1
            i32.const 4
            i32.add
            local.set 1
            local.get 5
            i32.const 4
            i32.add
            local.tee 5
            local.get 3
            i32.lt_u
            br_if 0 (;@4;)
            br 2 (;@2;)
          end
        end
        local.get 8
        i32.const 1
        i32.lt_s
        br_if 0 (;@2;)
        local.get 9
        local.set 1
        loop  ;; label = @3
          local.get 5
          local.get 1
          i32.load
          i32.store
          local.get 1
          i32.const 4
          i32.add
          local.set 1
          local.get 5
          i32.const 4
          i32.add
          local.tee 5
          local.get 3
          i32.lt_u
          br_if 0 (;@3;)
        end
      end
      local.get 7
      i32.const 3
      i32.and
      local.set 2
      local.get 9
      local.get 8
      i32.add
      local.set 1
    end
    block  ;; label = @1
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      local.get 2
      i32.add
      local.set 5
      loop  ;; label = @2
        local.get 3
        local.get 1
        i32.load8_u
        i32.store8
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        local.get 3
        i32.const 1
        i32.add
        local.tee 3
        local.get 5
        i32.lt_u
        br_if 0 (;@2;)
      end
    end
    local.get 0)
  (table (;0;) 26 26 funcref)
  (memory (;0;) 17)
  (global $__stack_pointer (mut i32) (i32.const 1048576))
  (global (;1;) i32 (i32.const 1049852))
  (global (;2;) i32 (i32.const 1049856))
  (export "memory" (memory 0))
  (export "__wbindgen_describe___wbg_alert_f30b78c50df83b2d" (func $__wbindgen_describe___wbg_alert_f30b78c50df83b2d))
  (export "greet" (func $greet))
  (export "__wbindgen_describe_greet" (func $__wbindgen_describe___wbg_alert_f30b78c50df83b2d))
  (export "__wbindgen_exn_store" (func $__wbindgen_exn_store))
  (export "__wbindgen_malloc" (func $__wbindgen_malloc))
  (export "__wbindgen_realloc" (func $__wbindgen_realloc))
  (export "__wbindgen_free" (func $__wbindgen_free))
  (export "__externref_table_alloc" (func $__externref_table_alloc))
  (export "__externref_table_dealloc" (func $__externref_table_dealloc))
  (export "__externref_drop_slice" (func $__externref_drop_slice))
  (export "__externref_heap_live_count" (func $__externref_heap_live_count))
  (export "__data_end" (global 1))
  (export "__heap_base" (global 2))
  (elem (;0;) (i32.const 1) func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h764538e45c6cfe1eE $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h14744b2f90deaafdE $_ZN3std5alloc24default_alloc_error_hook17heb8eb5c10c24f587E $_ZN4core3ptr100drop_in_place$LT$$RF$mut$u20$std..io..Write..write_fmt..Adapter$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$17h0499f59298030c64E $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17h7325a891291bec2fE $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hadb22ebda269801aE $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17hd159acdabb295994E $_ZN4core3ptr226drop_in_place$LT$std..error..$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$std..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$..from..StringError$GT$17h1ef7a4997c9d0324E $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h6fa6cd067880123dE $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17he101e458b14bb15cE $_ZN4core3ptr70drop_in_place$LT$std..panicking..begin_panic_handler..PanicPayload$GT$17h5d1b3c05875cdf66E $_ZN90_$LT$std..panicking..begin_panic_handler..PanicPayload$u20$as$u20$core..panic..BoxMeUp$GT$8take_box17hf88e93ea97bf61d3E $_ZN90_$LT$std..panicking..begin_panic_handler..PanicPayload$u20$as$u20$core..panic..BoxMeUp$GT$3get17h97c25dff6adc9fe7E $_ZN93_$LT$std..panicking..begin_panic_handler..StrPanicPayload$u20$as$u20$core..panic..BoxMeUp$GT$8take_box17h6910e5e3b12a5c08E $_ZN93_$LT$std..panicking..begin_panic_handler..StrPanicPayload$u20$as$u20$core..panic..BoxMeUp$GT$3get17haf427899f1e3b0d6E $_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17heedb7d44e2f9ac57E $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17h0852357214965ee3E $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h55342177fb966a77E $_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17he9763e63895c0f43E $_ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h5720878ff189bd51E $_ZN4core3ops8function6FnOnce9call_once17ha601a3bcb64de8fcE $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h7de26306900648efE $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hd053ae06518d545bE $_ZN4core3ptr102drop_in_place$LT$$RF$core..iter..adapters..copied..Copied$LT$core..slice..iter..Iter$LT$u8$GT$$GT$$GT$17h7c59c825a74d7577E $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h26da887aa8291663E)
  (data $.rodata (i32.const 1048576) "Hello, !\00\00\10\00\07\00\00\00\07\00\10\00\01\00\00\00\04\00\00\00\04\00\00\00\04\00\00\00\05\00\00\00\06\00\00\00\07\00\00\00called `Option::unwrap()` on a `None` valuememory allocation of  bytes failed\0a\00\00[\00\10\00\15\00\00\00p\00\10\00\0e\00\00\00library/std/src/alloc.rs\90\00\10\00\18\00\00\00R\01\00\00\09\00\00\00library/std/src/panicking.rs\b8\00\10\00\1c\00\00\00G\02\00\00\0f\00\00\00\b8\00\10\00\1c\00\00\00F\02\00\00\0f\00\00\00\08\00\00\00\0c\00\00\00\04\00\00\00\09\00\00\00\04\00\00\00\08\00\00\00\04\00\00\00\0a\00\00\00\0b\00\00\00\10\00\00\00\04\00\00\00\0c\00\00\00\0d\00\00\00\04\00\00\00\08\00\00\00\04\00\00\00\0e\00\00\00\0f\00\00\00\10\00\00\00\04\00\00\00\04\00\00\00\11\00\00\00\12\00\00\00\13\00\00\00library/alloc/src/raw_vec.rscapacity overflow\00\00\00p\01\10\00\11\00\00\00T\01\10\00\1c\00\00\00\06\02\00\00\05\00\00\00a formatting trait implementation returned an error\00\10\00\00\00\00\00\00\00\01\00\00\00\14\00\00\00library/alloc/src/fmt.rs\e0\01\10\00\18\00\00\00d\02\00\00\09\00\00\00\18\00\00\00\00\00\00\00\01\00\00\00\19\00\00\00: \00\00\08\02\10\00\00\00\00\00\18\02\10\00\02\00\00\0000010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899Error"))
